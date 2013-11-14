$:.push File.expand_path('../../lib', __FILE__)
require 'zulip'

### Sends a private message to a new thread is posted to a specified stream

class ZulipEcho
  client = Zulip::Client.new do |config|
    config.bot_email_address = "bot@example.com"
    config.bot_api_key = "apikey"
  end

  client.stream_messages do |message|
    if message.stream = "test-stream"
      pm_content = "#{message.sender_full_name}, posted to #{message.stream}:\n #{message.subject}: #{message.content}"
      client.send_private_message(pm_content, "ryanvergeront@gmail.com")
    end
  end
end
