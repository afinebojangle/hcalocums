class CreateAccruals < ActiveRecord::Migration[5.0]
  def change
    create_table :accruals do |t|
      t.belongs_to :coid, index: true
      t.string    :provider
      t.string    :agency
      t.date      :shift_date
      t.string    :expense_type
      t.float     :units
      t.float     :rate
      t.float     :accrual
      t.string    :reference_id
      t.string    :source
      t.integer   :month
      t.integer   :year
      
      t.timestamps
      
    end
  end
end
