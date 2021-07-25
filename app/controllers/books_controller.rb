class BooksController < ApplicationController
  before_action :authenticate_user!,only: [:create,:edit,:update,:destroy,:index]

  def index
    @book = Book.new
    if params[:rank]
      @books = Book.all.order(rate: "desc")
    elsif params[:new]
      @books = Book.all.order(created_at: "desc")  
    else
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
    @comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    screen_user(@book)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if params[:product_comment].present?
      @book.rate = params[:product_comment][:rate].to_i
    end
    
    if @book.save
      redirect_to @book
    else
      @books = Book.all
      render 'index'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_url
  end
  
  def search
    @books = Book.where(category: params[:search])
    @book = Book.new
    render :index
  end

  private
    def book_params
      params.require(:book).permit(:title, :body, :category)
    end

    def screen_user(book)
      if book.user.id != current_user.id
        redirect_to books_path
      end
    end

end
