class HistoricalImporter
  require 'csv'
  
  
  def self.import(file, coid_id)
    CSV.foreach(file, headers: true) do |row|
      
      #byebug
  
      next if row['PHYSICIAN'].blank?
      
      accrual_row = {}
      payment_row = {}
      
      accrual_row[:coid_id] = coid_id
      accrual_row[:physician] = row['PHYSICIAN']
      accrual_row[:agency] = row['LOCUMS AGENCY']
      accrual_row[:start_date] = Date.strptime(row['START DATE'], '%m/%d/%Y')
      accrual_row[:end_date] = Date.strptime(row['END DATE'], '%m/%d/%Y')
      accrual_row[:month] = Date.strptime(row['MONTH'], '%m/%d/%Y')
      accrual_row[:expense_type] = row['EXPENSE TYPE']
      accrual_row[:units] = row['# OF DAYS/HOURS']
      accrual_row[:rate] = row['RATE']
      accrual_row[:note] = row['COMMENTS']
      
      Accrual.create(accrual_row)
      
      next if row['INVOICE AMOUNT'].blank?
      
      payment_row[:coid_id] = coid_id
      payment_row[:shift_date] = Date.strptime(row['START DATE'], '%m/%d/%Y')
      payment_row[:agency] = row['LOCUMS AGENCY']
      payment_row[:physician] = row['PHYSICIAN']
      payment_row[:units] = row['# OF DAYS/HOURS']
      payment_row[:bill_rate] = row['INVOICE AMOUNT'].to_f / row['# OF DAYS/HOURS'].to_f
      payment_row[:billed_amount] = row['INVOICE AMOUNT']
      payment_row[:expense_type] = row['EXPENSE TYPE']
      payment_row[:comments] = row['COMMENTS']
      payment_row[:reference_id] = row['INVOICE #']
      payment_row[:bill_date] = Date.strptime(row['G/L Date'], '%m/%d/%Y')
      
      Payment.create(payment_row)

    end
    
  end
  
end