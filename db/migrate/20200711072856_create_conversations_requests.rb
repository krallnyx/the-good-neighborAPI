class CreateConversationsRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations_requests do |t|
      t.belongs_to :conversation, index: true
      t.belongs_to :request, index: true
    end
  end
end
