class Transaction < ApplicationRecord
  validates :amount_currency, presence: {message: "Please select currency"}
  validates :amount, :numericality => {:greater_than_equal => 0, message: "should be greater than 0"}
end
