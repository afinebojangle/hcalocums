class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.belongs_to  :coid, index: true
      t.date        :shift_date
      t.string      :agency
      t.string      :physician
      t.float       :units
      t.float       :bill_rate
      t.float       :billed_amount
      t.string      :expense_type
      t.string      :comments
      t.string      :reference_id
      t.date        :bill_date
      
      t.timestamps
      
      
    end
  end
end
