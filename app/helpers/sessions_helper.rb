module SessionsHelper
    def current_store
      @current_store ||= Store.find_by(id: session[:store_id])
    end
  
    def logged_in?
      current_store.present?
    end
  end
  