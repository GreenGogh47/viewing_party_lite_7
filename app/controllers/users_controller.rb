class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.password == params[:user][:password_confirmation]
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "User successfully created"
        redirect_to "/users/#{@user.id}"
      else
        flash[:error] = error_message(@user.errors)
        redirect_to "/register"
      end
    else
      flash[:error] = "Password confirmation doesn't match Password"
      redirect_to "/register"
    end
  end

  def show
    @user = User.find(params[:id])
    @user_viewing_parties = @user.parties
    @movie_facade = MovieFacade.new
  end

  def login_form
  end

  def login
    user = User.find_by(email: params[:email])
    if user.nil?
      flash[:notice] = "Invalid Credentials"
      redirect_to '/login'
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}"
    else
      flash[:notice] = "Invalid Credentials"
      redirect_to '/login'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
