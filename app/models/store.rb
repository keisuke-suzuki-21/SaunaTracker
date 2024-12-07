class Store < ApplicationRecord
    has_many :transactions, dependent: :destroy # トランザクションとの関連
    has_many :histories, through: :transactions # トランザクションを通じた履歴との関連

    validates :name, presence: true
    validates :location, presence: true

    # リアルタイム利用者数を計算して返す
  def current_occupancy
    transactions.where(action: 'entry').count
  end
end
