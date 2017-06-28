class Coid < ApplicationRecord
  has_many :accruals
  has_many :payments
  
  scope :name_list, -> { (select(:id, "coid || ': ' || name as name")) }
  
end