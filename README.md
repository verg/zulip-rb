# Zulip-Rb

A ruby interface to the Zulip API.

### Installation

Add this line to your application's Gemfile:

`gem 'zulip'`

And then execute:

`$ bundle`

Or install it yourself as:

`$ gem install zulip-rb`

### Configuration
You can obtain your Zulip API key, create bots, and manage bots all
from your Zulip [settings page](https://zulip.com/#settings).

Set your api key and email address by passing a block to your Zulip::Client instance:
```ruby
client = Zulip::Client.new do |config|
config.email_address = "YOUR_EMAIL_ADDRESS"
config.api_key = "YOUR_API_KEY"
end
```

### Usage

Send messages to a stream:
```ruby
client.send_message("Hey", "I'm posting to zulip", "test-stream")
```

Send private messages to one or more users:
```ruby
client.send_private_message("hey I heard you like the internet", "bob@the-internet.net", "alice@the-information-superhighway.org")
```

Stream messages:
```ruby
client.stream_messages do |message|
# Do some work
end
```

Get your current subscriptions:
```ruby
client.get_subscriptions
```

Subscribe to a stream, passing the stream name:
```ruby
client.subscribe "food"
```

List users:
```ruby
client.get_users
```

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Some areas that could use contributions:

1. Error handling
2. Add unsubscribing from a stream
