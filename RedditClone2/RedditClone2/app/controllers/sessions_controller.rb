class SessionsController < ApplicationController
  before_action :require_no_login, except: [:destroy]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      render text: "Homepage"
    else
      flash.now[:errors] = ["Invalid Credentials"]
      render :new
    end
  end

  def destroy
    logout
    # redirect to root
  end
end
