require 'helper'
require_relative "../../../../lib/zulip"

describe Zulip::EventStreaming do
  it 'issues a longpulling request for new events' do
    fake_connection = double("fake connection", :params= => nil)
    fake_response = double("response", body: fixture("get-message-event-success.json"))
    fake_connection.stub(:get).with('/v1/events').and_return(fake_response)

    client = Zulip::Client.new
    client.connection = fake_connection

    registered_queue = double("queue", queue_id: "id", last_event_id: -1)
    response = client.get_events(registered_queue)

    expect(response).to eq JSON.parse(fixture("get-message-event-success.json")).fetch("events")
  end
end
