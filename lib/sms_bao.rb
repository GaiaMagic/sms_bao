require 'sms_bao/version'
require 'uri'
require 'json'
require 'net/http'

module SMSBao
  BASE_GATEWAY = 'http://api.smsbao.com/%s'

  @timeout = 5

  class << self
    attr_accessor :username, :md5_password, :signature, :timeout
  end

  def self.send_to!(recipients, content)
    Request.new('sms', recipients, content).perform!
  end

  def self.quota
    response = Request.new('query').perform!
    response.split(',').last.to_i
  end

  class Request
    attr_accessor :uri, :params

    def initialize(action, recipients = nil, content = nil)
      @params = { u: SMSBao.username, p: SMSBao.md5_password }
      @params[:m] = Array(recipients).join(',') if recipients
      @params[:c] = "#{SMSBao.signature} #{content}" if content

      @uri = URI(BASE_GATEWAY % action)
      @uri.query = URI.encode_www_form(params)
    end

    def perform!
      timeout = SMSBao.timeout

      response = Net::HTTP.start(uri.host,
                                  uri.port,
                                  open_timeout: timeout,
                                  read_timeout: timeout) do |http|
        http.get(uri.request_uri)
      end

      code, error_msg = response.body.split("\n")
      code == '0' ? error_msg : raise(RequestException.new(code))
    end
  end

  class RequestException < StandardError
    ERROR_MESSAGES = {
      '-1' => 'Invalid phone number',
      '1'  => 'Network error.',
      '30' => 'Incorrect username/password.',
      '40' => 'Account not existed.',
      '41' => 'No quota available.',
      '42' => 'Account expired.',
      '43' => 'IP address denied.',
      '50' => 'Got fucked by state censorship.',
      '51' => 'Incorrect cell-phone number.'
    }

    def initialize(code)
      super(ERROR_MESSAGES[code] || code)
    end
  end
end
