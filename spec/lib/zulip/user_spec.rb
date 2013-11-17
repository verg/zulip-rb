require_relative "../../../lib/zulip"

module Zulip
  describe User do
    it "has an email" do
      data = {"email"=>"bob@example.org","full_name"=>"Bob G"}
      user = User.new(data)
      expect(user.email).to eq "bob@example.org"
    end

    it "has a full name" do
      data = {"email"=>"bob@example.org","full_name"=>"Bob G"}
      user = User.new(data)
      expect(user.full_name).to eq "Bob G"
    end
  end
end
