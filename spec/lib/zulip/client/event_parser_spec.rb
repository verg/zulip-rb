require_relative "../../../../lib/zulip"
require 'helper'

describe Zulip::EventParser do
  it "parses message events" do
    event_hash = parsed_json_fixture("get-message-event-success.json")['events'].first
    result = Zulip::EventParser.parse(event_hash)
    expect(result).to be_kind_of Zulip::Message
  end

  it "parses heartbeat events"
  it "parses presence events"
  it "parses subscriptions events"
  it "parses error events"
end
