class UsersController < ApplicationController

  def create
    if @user.create(user_params)
      flash[:seccess] = "Welcome! You have signed up successfully."
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    @users = User.all #ユーザ一覧画面
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = Book.where(user_id:@user.id)
  end

  def edit
    @user = User.find(params[:id])

    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success_update_user] = "You have updated user successfully."
      redirect_to user_path(@user.id)

    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
