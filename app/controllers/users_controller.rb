class UsersController < ApplicationController
	before_action :baria_user, only: [:update]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）

  def new
    @user = User.new
    @book = Book.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Plofile was successfully createed.'
      redirect_to admin_user_url(@user)
    else
      render :new
    end

    @book = Book.new(book_params)
       @book.user_id = current_user.id
    if @book.save
        flash[:notice] = 'Book was successfully created.'
        redirect_to book_path(@book.id)
    else
        @books = Book.all
        render :index
    end
  end


  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to users_path(@user), notice: "successfully updated user!"
  	else
  		render "show"
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
   end

  end
end