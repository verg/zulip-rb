require_relative "../../../lib/zulip"

module Zulip
  describe Message do
    let(:data) { {
      "recipient_id"=>23442,
      "sender_email"=>"ryanvergeront@gmail.com",
      "timestamp"=>1384460690,
      "display_recipient"=>"test-stream",
      "sender_id"=>2874,
      "sender_full_name"=>"Ryan Vergeront (F'13)",
      "sender_domain"=>"students.hackerschool.com",
      "content"=>"register an event type of 'message' not 'messages'",
      "gravatar_hash"=>"a8e2e659c929c79669f97603bd73fcc5",
      "avatar_url"=>
      "https://secure.gravatar.com/avatar/a8e2e659c929c79669f97603bd73fcc5?d=identicon",
        "client"=>"desktop app Mac 0.3.10",
        "content_type"=>"text/x-markdown",
        "subject_links"=>[],
        "sender_short_name"=>"ryanvergeront",
        "type"=>"stream",
        "id"=>12791579,
        "subject"=>"sending some internet websites to the internet" } }

    it "implements attr_readers for it's attributes" do
      message = Message.new(data)
      expect(message.sender_email).to eq "ryanvergeront@gmail.com"

      data.keys.each do |name|
        return_value = message.send(name.to_sym)
        expect(return_value).not_to be_nil
      end
      expect(message.stream).to eq "test-stream"
    end
  end
end
