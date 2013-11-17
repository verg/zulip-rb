require_relative "../../../lib/zulip"

module Zulip
  describe StreamSubscription do
    let(:data) { { "name"=>"VIM",
                   "color"=>"#76ce90",
                   "notifications"=>false,
                   "subscribers"=>["bob@example.com", "alice@example.com"],
                   "invite_only"=>false,
                   "email_address"=>"VIM@streams.zulip.com",
                   "in_home_view"=>true } }

    it "has attrs" do
      subscription = StreamSubscription.new(data)
      data.each do |key, value|
        expect(subscription.send(key)).to eq value
      end
    end

  end
end
