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
  {name: "WFL Medical Group - Avalon", coid: 21070, division: "NFL", group: "National Group", market: "Pensacola"},
  
]


#create coid record for each coid above
coids.each do |coid|
  Coid.create!(coid)
end

puts "Created #{Coid.all.count} COIDs"


#seed avalon accruals

coid = Coid.where(name: "WFL Medical Group - Avalon").first.id

require 'csv'

CSV.foreach("lib/files/WFL Medical Group - Avalon Accural Example.csv", headers: true) do |row|
  row = row.to_hash
  row.merge!({coid_id: coid})
  row["start_date"] = Date.strptime(row["start_date"], '%m/%d/%Y')
  row["end_date"] = Date.strptime(row["end_date"], '%m/%d/%Y')
  row["month"] = Date.strptime(row["month"], '%m/%d/%Y')
  Accrual.create(row)
end

puts "Created #{Accrual.all.count} Accrual Records"


#seed avalon invoice

CSV.foreach("lib/files/21070 Invoice Feb 2017.csv", headers: true) do |row|
  new_row = {}
  
  new_row[:coid_id] = coid
  new_row[:shift_date] = Date.strptime(row['ShiftDate'], '%m-%d-%y')
  new_row[:agency] = row['Provider']
  new_row[:physician] = row['Employee']
  new_row[:hours] = row['Hours']
  new_row[:bill_rate] = row['BillRate']
  new_row[:billed_amount] = row['BilledAmount']
  new_row[:expense_type] = row['TransType']
  new_row[:comments] = row['Comment']
  new_row[:reference_id] = row['ReferenceID']
  new_row[:bill_date] = Date.strptime(row['Bill_Date'], '%Y-%m-%d')
  
  Payment.create(new_row)
end

puts "Created #{Payment.all.count} Payment Records"
  