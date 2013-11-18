$:.push File.expand_path('../../lib', __FILE__)
require 'zulip'

### Sends a private message to a new thread is posted to a specified stream

class ZulipEcho

  def run
    client = Zulip::Client.new do |config|
      config.bot_email_address = ENV['BOT_EMAIL_ADDRESS'] || "bot@example.com"
      config.api_key = ENV['BOT_API_KEY'] || "apikey"
    end

    client.stream_messages do |message|
      if message.stream == "test-stream"
        client.send_private_message(private_message_content(message), "ryanvergeront@gmail.com")
      end
    end
  end

  private

  def private_message_content(message)
    "#{message.sender_full_name}, posted to #{message.stream}:\n #{message.subject}: #{message.content}"
  end
end

ZulipEcho.new.run
