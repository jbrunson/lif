class AddTokenAndExpiresAtToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :token, :string
    add_column :identities, :token_expires_at, :string
  end
end
