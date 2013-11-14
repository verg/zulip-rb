require 'helper'
require_relative "../../../../lib/zulip"

describe Zulip::QueueRegistration do
  describe "registering a queue to stream messages" do
    context "with an event type of messages" do
      it "posts to the register api" do
        client = Zulip::Client.new
        fake_connection = double("fake connection")
        fake_response = double("response", body: fixture("queue-registration-success.json"))
        fake_connection.stub(:post).with("/v1/register").and_return(fake_response)
        client.connection = fake_connection

        fake_connection.should_receive(:params=).with( { "event_types" => '["message"]' } )
        fake_connection.should_receive(:post).with("/v1/register")

        stream_type = :message
        client.register(stream_type)
      end

      it "returns an object with the queue's id and last event id" do
        client = Zulip::Client.new
        fake_response = double("response", body: fixture("queue-registration-success.json"))
        fake_connection = double("fake connection", :params= => nil )
        fake_connection.stub(:post).with("/v1/register").and_return(fake_response)
        client.connection = fake_connection

        the_expected_queue_id = "1384438093:1161"
        the_expected_last_event_id = -1
        stream_type = :message
        response = client.register(stream_type)

        expect(response.queue_id).to eq the_expected_queue_id
        expect(response.last_event_id).to eq the_expected_last_event_id
      end
    end
  end
end
