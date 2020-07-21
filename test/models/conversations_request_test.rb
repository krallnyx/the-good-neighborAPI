require 'test_helper'

class ConversationsRequestTest < ActiveSupport::TestCase
 
 test "is valid with required data" do
    conv = ConversationsRequest.new(conversation_id: 1, request_id: 1)
    assert conv.valid?
  end

end
