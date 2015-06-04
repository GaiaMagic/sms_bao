require 'test_helper'

class SMSBaoTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SMSBao::VERSION
  end

  def test_send_to_success
    stub_request(:get, %r(http://api.smsbao.com/.*)).
      to_return(status: 200, body: "0\n")

    assert_nil ::SMSBao.send_to!('1234567890', 'hello')
  end

  def test_send_to_fail
    stub_request(:get, %r(http://api.smsbao.com/.*)).
      to_return(status: 200, body: "30\nerror-message")

    assert_raises(::SMSBao::RequestException) { ::SMSBao.send_to!('1234567890', 'hello') }
  end

  def test_quota
    quota = rand(1000)
    stub_request(:get, %r(http://api.smsbao.com/.*)).
      to_return(status: 200, body: "0\n12,#{quota}")

    assert_equal quota, ::SMSBao.quota
  end
end
