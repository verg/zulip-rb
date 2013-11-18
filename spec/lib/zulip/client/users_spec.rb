require 'helper'
require_relative "../../../../lib/zulip"

describe Zulip::Users do
  describe "get_users" do
    it "returns users in the bot's realm" do

      fake_http_response = double("fake http response", body: fixture("get-users.json"))
      fake_connection = double("fake connection", get: fake_http_response)

      client = Zulip::Client.new
      client.connection = fake_connection

      users = client.get_users
      expect(users.first).to be_kind_of Zulip::User
      expect(users.last).to be_kind_of Zulip::User
    end
  end

end
