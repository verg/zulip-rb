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

    fake_connection.should_receive(:params=).with({"type"=>"stream", "content"=>content,
                                                   "to" => stream, "subject"=>subject})
    fake_connection.should_receive(:post).with("v1/messages")
    client.send_message(subject, content, stream)
  end

  it "sends private messages to a single user" do
    content = "Hi, I heard you like the internet. Here: http://en.wikipedia.org/wiki/Zebroid"
    recipient  = "internet_cat@example.com"

    client = Zulip::Client.new

     fake_response = fixture("sending-private-message-success.json")
     fake_connection = double("fake connection", post: fake_response )
     client.connection = fake_connection

    fake_connection.should_receive(:params=).with({"type"=>"private", "content"=>content,
                                                   "to" => recipient})
    fake_connection.should_receive(:post).with("v1/messages")
    client.send_private_message(content, recipient)
  end

  it "sends private messages to multiple users"
end
