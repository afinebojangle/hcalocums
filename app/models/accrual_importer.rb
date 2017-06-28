class AccrualImporter
  require 'csv'
  
  def self.import(file, coid_id:, accrual_month:, accrual_year:)
    
    begin
      accrual_rows = []
      
      CSV.foreach(file, headers: true) do |row|
        
        next if row['Facility'].blank?
        
        accrual_row = {}
        
        accrual_row[:coid_id] = coid_id
        accrual_row[:provider] = row['Employee']
        accrual_row[:agency] = row['Provider']
        accrual_row[:shift_date] = Date.strptime(row['ShiftDate'], '%Y-%m-%d')
        accrual_row[:expense_type] = row['Transaction']
        accrual_row[:units] = row['Hours'].gsub(/,/, "").to_f
        accrual_row[:rate] = row['BillRate'].gsub(/,/, "").to_f
        accrual_row[:accrual] = row['Accrual'].gsub(/,/, "").to_f
        accrual_row[:reference_id] = row['ReferenceID']
        accrual_row[:source] = row['SourceTable']
        accrual_row[:month] = accrual_month
        accrual_row[:year] = accrual_year
        
        accrual_rows << accrual_row
      end
      
    rescue
      return false
    else
      Accrual.create(accrual_rows)
    end
  end
end