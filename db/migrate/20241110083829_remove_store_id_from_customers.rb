class RemoveStoreIdFromCustomers < ActiveRecord::Migration[7.0]
  def change
    remove_reference :customers, :store, foreign_key: true
  end
end
