require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  test "is valid with required data" do
    conv = Message.new(conversation_id: 1, to_id: 1, from_id: 2, body: 'Hi John')
    assert conv.valid?
  end

  test "is invalid without message body" do
    message = Message.new(conversation_id: 1, to_id: 1, from_id: 2, body: '')
    assert_not_nil message.errors[:body]
  end

end
