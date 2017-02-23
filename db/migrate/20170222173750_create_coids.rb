class CreateCoids < ActiveRecord::Migration[5.0]
  def change
    create_table :coids do |t|
      t.string  :name
      t.integer :coid, index: true
      t.string  :division
      t.string  :market
      t.string  :group
      
      t.timestamps
      
    end
  end
end
