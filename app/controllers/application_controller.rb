class ApplicationController < ActionController::Base
    before_action :require_login

    helper_method :current_store, :logged_in?

    private

    def current_store
        @current_store ||= Store.find_by(id: session[:store_id])
    end

    def logged_in?
        current_store.present?
    end

    def require_login
        unless logged_in?
        redirect_to login_path, alert: 'ログインしてください'
        end
    end
end
