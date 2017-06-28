class Payment < ApplicationRecord
  belongs_to :coid
  
  def self.import(file, coid_id)
    
  end
  
end