class ReconcileController < SecuredController
  
  def index
    
  end
  
  def month
    @coids = Coid.name_list
    @months= [
      {name: "January", number: 1},
      {name: "Febrary", number: 2},
      {name: "March", number: 3},
      {name: "April", number: 4},
      {name: "May", number: 5},
      {name: "June", number: 6},
      {name: "July", number: 7},
      {name: "August", number: 8},
      {name: "September", number: 9},
      {name: "October", number: 10},
      {name: "November", number: 11},
      {name: "December", number: 12}
    ]
    @years = get_year_list
    
    
    
  end
  
  
  

  private
  
  def get_year_list
    year_list = []
    counter = 0
    while counter < (Date.today.year + 1 - 2009) do
      year_list << (Date.today.year + 1 - counter)
      counter += 1
    end
    
    year_list
  end
      
  
  
  
end