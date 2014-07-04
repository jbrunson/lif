class AddConversationToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :conversation_id, :integer
  end
end
