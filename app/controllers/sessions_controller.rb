class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    store = Store.find_by(login_id: params[:login_id])
    if store&.authenticate(params[:password])
      session[:store_id] = store.id
      redirect_to root_path, notice: 'ログインに成功しました'
    else
      flash.now[:alert] = 'ログインIDまたはパスワードが正しくありません'
      render :new
    end
  end

  def destroy
    session[:store_id] = nil
    redirect_to login_path, notice: 'ログアウトしました'
  end
end
  