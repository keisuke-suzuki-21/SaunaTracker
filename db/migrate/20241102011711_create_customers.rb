class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.references :store, null: false, foreign_key: true
      t.datetime :entry_time, null: false
      t.datetime :exit_time
      t.uuid :uuid, default: 'gen_random_uuid()', null: false

      t.timestamps
    end
  end
end
