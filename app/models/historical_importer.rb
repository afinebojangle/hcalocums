class HistoricalImporter
  require 'csv'
  
  
  def self.import(file, coid_id)
    
    
    begin
    
      
      #these are to used to ensure that the same historical data file can be imported over and over without creating duplicate entries
      
      previous_payments = Payment.where(coid: coid_id).pluck(:reference_id)
      
      last_accrual_date = load_last_accrual_date(coid_id)
    
      
      #these house the individual rows so we can either write all or none to the DB
      accruals = []
      payments = []
      
      #Loops through each CSV row and seperates the payment and accrual and formats for saving to DB
      CSV.foreach(file, headers: true) do |row|
        
        accrual_row = {}
        payment_row = {}
        
        #skip blank rows
        next if row['PHYSICIAN'].blank?
        
        
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
        
        #only want to keep rows that have not already been imported      
        accruals << accrual_row if Date.strptime(row['ACCRUAL DATE'], '%m/%d/%Y') >= last_accrual_date
        
        #skip unpaid rows
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
        payment_row[:reference_id] = row['INVOICE #'].to_i
        payment_row[:bill_date] = Date.strptime(row['G/L Date'], '%m/%d/%Y')
        
        #skip already imported payment data
        payments << payment_row unless previous_payments.include?(payment_row[:reference_id])
        
      end
      
    rescue
    
      return false
      
    else
      #only save rows to database if the entire import succeeds.
      Accrual.create(accruals)
      Payment.create(payments)
      
      return true
      

    end
    
  end
  
  
  private
  
  def self.load_last_accrual_date(coid_id)
  #returns a date to compare to the accrual date so that import is idempotent.  
    begin
      Accrual.where(coid: coid_id).maximum(:created_at).to_date
    rescue
      Date.new(1900, 1, 1)
    end
  end
  
end