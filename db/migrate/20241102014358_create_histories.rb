class CreateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.references :transaction, foreign_key: true, null: false # 対象となるトランザクションの外部キー
      t.string :action, null: false # トランザクションのアクション（'entry' または 'exit'）
      t.string :status, null: false # トランザクションのステータス

      t.timestamps
    end
  end
end
