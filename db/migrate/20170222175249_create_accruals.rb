class CreateAccruals < ActiveRecord::Migration[5.0]
  def change
    create_table :accruals do |t|
      t.belongs_to :coid, index: true
      t.string :physician
      t.string :agency
      t.date    :start_date
      t.date    :end_date
      t.date    :month
      t.string  :expense_type
      t.float   :units
      t.float   :rate
      t.string  :note
      
      t.timestamps
      
    end
  end
end
