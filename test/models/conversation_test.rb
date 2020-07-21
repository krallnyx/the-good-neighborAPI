require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
 
  test "is valid with required data" do
    conv = Conversation.new(subject: "Dog walking")
    assert conv.valid?
  end

end
