require 'helper'
require_relative "../../../../lib/zulip"

describe Zulip::Messages do
  it "posts a message to a stream" do
    subject = "sending some internet websites to the internet"
    content = "Hey, I found this on the internet: http://nbapaintings.blogspot.com/"
    stream = "test-stream"

    client = Zulip::Client.new
    fake_response = fixture("post-message-to-stream.json")
    fake_connection = double("fake connection", post: fake_response )
    client.connection = fake_connection

    fake_connection.should_receive(:post).with("v1/messages")
    client.send_message(subject, content, stream)
  end
end
