require 'helper'
require_relative "../../../../lib/zulip"

module Zulip
  class Client
    describe StreamSubscriptions do
      describe "#get_subscriptions" do
        it "returns the user's stream subscriptions" do
          fake_http_response = double("fake http response",
                                      body: fixture("get-user-subscriptions.json"))
          fake_connection = double("fake connection", get: fake_http_response)

          client = Zulip::Client.new
          client.connection = fake_connection

          subscriptions = client.get_subscriptions
          expect(subscriptions.first).to be_a Zulip::StreamSubscription
          expect(subscriptions.last).to be_a Zulip::StreamSubscription
        end
      end

      describe "#subscribe" do
        it "sends a PATCH message to subscribe the user to a stream" do
          fake_http_response = double("fake response",
                                      body: fixture("add-subscription.json"))
          fake_connection = double("fake connection", patch: fake_http_response)

          client = Zulip::Client.new
          client.connection = fake_connection

          expected_params = ["v1/users/me/subscriptions",
                             {:add=>"[{\"name\":\"clojure\"},{\"name\":\"ruby\"}]"}]
          fake_connection.should_receive(:patch).with(*expected_params)

          streams = ["clojure", "ruby"]
          client.subscribe(streams)
        end
      end

    end
  end
end
