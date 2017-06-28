class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.belongs_to    :coid, index: true
      t.string        :first_name
      t.string        :last_name
      t.string        :parallon_name
      t.boolean       :active, default: true, null: false
      t.date          :start_date
      t.date          :end_date
      t.string        :speciality
      
      
      t.timestamps
    end
  end
end
