class Customer < ApplicationRecord
  has_many :transactions, dependent: :destroy # トランザクションとの関連
  has_many :histories, through: :transactions # トランザクションを通じた履歴との関連

  validates :name, presence: true
  validates :location, presence: true
end
