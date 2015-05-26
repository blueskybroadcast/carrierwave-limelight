# Carrierwave::Limelight

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'carrierwave-limelight'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install carrierwave-limelight

## Configure

```
  CarrierWave.configure do |config|
    self.limelight_credentials = {
      provider: 'limelight',
      limelight_username: ENV['LIMELIGHT_USERNAME'],
      limelight_password: ENV['LIMELIGHT_PASSWORD']
    }
    self.root_path = '/username/path'
    self.asset_host = 'http://username.vo.llnwd.net/o10'
  end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/carrierwave-limelight/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
