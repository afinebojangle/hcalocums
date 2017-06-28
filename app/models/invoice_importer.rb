class InvoiceImporter
  require 'csv'
  
  def self.import(file, coid_id:)
    
    begin
      invoice_rows = []
      
      CSV.foreach(file, headers: true) do |row|
        
        next if row['Facility'].blank?
        
        invoice_row = {}
        
        invoice_row[:coid_id] = coid_id
        invoice_row[:shift_date] = Date.strptime(row['ShiftDate'], '%m-%d-%Y')
        invoice_row[:agency] = row['Provider']
        invoice_row[:physician] = row['Employee']
        invoice_row[:units] = row['Hours'].gsub(/,/, "").to_f
        invoice_row[:bill_rate] = row['BillRate'].gsub(/,/, "").to_f
        invoice_row[:billed_amount] = row['BilledAmount'].gsub(/,/, "").to_f
        invoice_row[:expense_type] = row['TransType']
        invoice_row[:comments] = row['Comment']
        invoice_row[:reference_id] = row['ReferenceID']
        invoice_row[:bill_date] = Date.strptime(row['Bill_Date'], '%Y-%m-%d')
        
        invoice_rows << invoice_row
      end
      
    rescue
      return false
    else
      Payment.create(invoice_rows)
    end
  end
end