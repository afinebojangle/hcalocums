class ImportHistoricalController < SecuredController
  
  def index
    @coids = Coid.name_list
  end
  
  def create
    if HistoricalImporter.import(params[:file].path, params[:coid])
      flash[:notice] = "File Imported"
      redirect_to import_historical_path
    else
      flash[:error] = "Something went wrong with your import. Check instructions and try again"
      redirect_to import_historical_path
    end
  end
  
  
end