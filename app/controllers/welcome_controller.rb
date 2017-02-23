class WelcomeController < ApplicationController
    before_action :route_user, only: :index
    
    def index
    end
    
    
    
    private
    
    def route_user
      redirect_to dashboard_path if current_user
    end



end
