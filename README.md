# SMSBao

Ruby SDK for www.smsbao.com

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gm-sms_bao', require: 'sms_bao'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gm-sms_bao

## Usage

### Config

```ruby
SMSBao.username = 'username'
SMSBao.md5_password = 'md5-password'
SMSBao.signature = '【xxx】'
```

### Send sms

```ruby
SMSBao.send_to!('10086', '流量唔够用啊')
# SMSBao.send_to!(['10086', '10010'], '信号好差啊')
```

### Get quota

```ruby
SMSBao.quota # => 123
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sms_bao. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

