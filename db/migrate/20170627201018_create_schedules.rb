class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.belongs_to  :coid, index: true
      t.string      :provider
      t.string      :agency
      t.date        :date
      t.integer     :month
      t.integer     :year
      t.float       :units
      t.string      :uom
      
      t.timestamps
    end
  end
end
