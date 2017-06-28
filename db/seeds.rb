#Seed Rayford

user = User.new(
  first_name: "Rayford",
  last_name:  "Taylor",
  email:      "rayford.taylor@hcahealthcare.com",
  password:   "helloworld",
  password_confirmation:  "helloworld"
)

user.skip_confirmation!
user.save



#List Seed COIDs
coids = [
  {name: "WFL Behavorial Health", coid: 3885, division: "NFL", group: "National Group", market: "Pensacola"},
  
]


#create coid record for each coid above

coids.each do |coid|
  Coid.create!(coid)
end

puts "Created #{Coid.all.count} COIDs"


#seed WFL Behavorial accruals

seed_coid_id = Coid.where(name: "WFL Behavorial Health").first.id

require 'csv'

AccrualImporter.import("#{Rails.root}/lib/files/3885 May Accrual Example.csv", coid_id: seed_coid_id, accrual_month: 5, accrual_year: 2017)

puts "Created #{Accrual.all.count} Accrual Records"

#seed WFL Behavorial invoice

InvoiceImporter.import("#{Rails.root}/lib/files/3885 May Invoice Example.csv", coid_id: seed_coid_id)

puts "Created #{Payment.all.count} Payment Records"
  