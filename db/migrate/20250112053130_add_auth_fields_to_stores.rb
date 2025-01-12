class AddAuthFieldsToStores < ActiveRecord::Migration[7.0]
  def change
    add_column :stores, :login_id, :string
    add_column :stores, :password_digest, :string
  end
end
