class Coid < ApplicationRecord
  has_many :accruals
  has_many :payments
  
end