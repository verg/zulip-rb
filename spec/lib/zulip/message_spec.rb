require_relative "../../../lib/zulip"

module Zulip
  describe Message do
    let(:message_data) { {
      "recipient_id"=>23442,
      "sender_email"=>"example@example.com",
      "timestamp"=>1384460690,
      "display_recipient"=>"test-stream",
      "sender_id"=>2874,
      "sender_full_name"=>"Bob (F'13)",
      "sender_domain"=>"students.hackerschool.com",
      "content"=>"register an event type of 'message' not 'messages'",
      "gravatar_hash"=>"a8e2e659c929c79669f97603bd73fcc5",
      "avatar_url"=>
      "https://secure.gravatar.com/avatar/a8e2e659c929c79669f97603bd73fcc5?d=identicon",
        "client"=>"desktop app Mac 0.3.10",
        "content_type"=>"text/x-markdown",
        "subject_links"=>[],
        "sender_short_name"=>"bob",
        "type"=>"stream",
        "id"=>12791579,
        "subject"=>"sending some internet websites to the internet" } }

    it "implements attr_readers for it's attributes" do
      message = Message.new(message_data)
      expect(message.sender_email).to eq "example@example.com"

      message_data.keys.each do |name|
        return_value = message.send(name.to_sym)
        expect(return_value).not_to be_nil
      end
      expect(message.stream).to eq "test-stream"
    end

    let(:pm_data) { {"recipient_id"=>25104,
                  "sender_email"=>"test_zulip_cli-bot@students.hackerschool.com",
                  "timestamp"=>1384536182,
                  "display_recipient"=>
    [{"domain"=>"students.hackerschool.com",
      "short_name"=>"bob",
      "email"=>"example@example.com",
      "full_name"=>"Bob",
      "id"=>2874},
      {"full_name"=>"A Bot",
       "domain"=>"students.hackerschool.com",
       "email"=>"test_zulip_cli-bot@students.hackerschool.com",
       "short_name"=>"test_zulip_cli-bot",
       "id"=>2934}],
       "sender_id"=>2934,
       "sender_full_name"=>"A Bot",
       "sender_domain"=>"students.hackerschool.com",
       "content"=>
    "Bob (F'13), posted to test-stream:\n sending some internet websites to the internet: :)",
      "gravatar_hash"=>"9edc706c9ea089025a4bede65630866b",
      "avatar_url"=>
    "https://secure.gravatar.com/avatar/9edc706c9ea089025a4bede65630866b?d=identicon",
      "client"=>"API",
      "content_type"=>"text/x-markdown",
      "subject_links"=>[],
      "sender_short_name"=>"test_zulip_cli-bot",
      "type"=>"private",
      "id"=>12836310,
      "subject"=>""} }

    it "works for private messages" do
      pm = Message.new(pm_data)
      expect(pm.display_recipients).to be_a(Array)

      pm_data.each do |name, value|
        unless value.class == Array
          return_value = pm.send(name.to_sym)
          expect(return_value).not_to be_nil
        end
      end

    end
  end
end
