class CategoriesController < ApplicationController

  # http_basic_authentiaction_with name: "Zeno", password: "elementary", except [:index, :show]

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      render 'new'
    end
  end

  def show
    @category = get_category(params[:name])
    if @category.nil?
      redirect_to categories_path
    end
  end

  def edit
    @category = get_category(params[:name])
  end

  def update
    @category = get_category(params[:category][:name])
    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category = get_category(params[:name])
    @category.destroy
    redirect_to categories_path
  end

  private
    def category_params
      params.require(:category).permit(:name, :text)
    end

    def get_category name
      Category.where('lower(name) = ?', name.downcase).first
    end
end
