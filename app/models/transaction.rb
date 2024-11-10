class Transaction < ApplicationRecord
    belongs_to :store
    belongs_to :customer
  
    validates :action, presence: true, inclusion: { in: %w[entry exit] }
    validates :day_of_week, presence: true, inclusion: { in: 0..6 }
    validates :time_of_day, presence: true, inclusion: { in: %w[morning afternoon evening night] }
  
    # 滞在時間を計算し、duration に格納するメソッド
    def calculate_duration(entry_time, exit_time)
      self.duration = (exit_time - entry_time).to_i / 60 # 分単位で計算
    end
end