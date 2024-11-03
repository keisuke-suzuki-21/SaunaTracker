class History < ApplicationRecord
    belongs_to :transaction
  
    validates :action, presence: true, inclusion: { in: %w[entry exit] }
    validates :status, presence: true
end