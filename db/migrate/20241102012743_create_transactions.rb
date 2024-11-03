class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :store, foreign_key: true, null: false # サウナ店舗の外部キー
      t.references :customer, foreign_key: true, null: false # 顧客の外部キー
      t.string :action, null: false # 'entry' または 'exit'
      t.integer :duration # 滞在時間（入場と退場の差分を格納）
      t.integer :day_of_week, null: false # 曜日（0 = 日曜, 6 = 土曜）
      t.string :time_of_day, null: false # 来店の時間帯（例: morning, afternoon など）
      t.datetime :action_timestamp, null: false # 入退場の日時を示すカスタムフィールド

      t.timestamps
    end
  end
end
