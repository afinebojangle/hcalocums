module  DeviseHelper
  def devise_error_messages!
    if resource.errors.full_messages.count == 0
      return
    else 
      flash[:validation] = resource.errors.full_messages
      return
    end
  end
end