class ArticlesController < ApplicationController

  # http_basic_authentiaction_with name: "Zeno", password: "elementary", except [:index, :show]

  def new
    @article = Article.new
    @article.name = params[:name]
    if !@article.name.nil?
      create
    end
  end

  def index
    @articles = Article.all
  end

  def create
    @category = get_category params[:category_name]
    #@article = Article.new(article_params)
    @article = @category.articles.create(article_params)

    @article.save
    if @article.save
      redirect_to article_path(name: @article.name)
    else
      render 'new'
    end
  end

  def show
    @article = get_article(params[:name])
    @category = get_category(params[:category_name])
    if @article.nil?
      redirect_to category_path(name: :category_name)
    end
  end

  def edit
    @article = get_article(params[:name])
  end

  def update
    @article = get_article(params[:name])
    if @article.update(article_params)
      redirect_to article_path(name: @article.name)
    else
      render 'edit'
    end
  end

  def destroy
    @article = get_article(params[:name])
    @article.destroy
    redirect_to category_path(name: params[:category_name])
  end

  private
    def article_params
      #params.require(:article).permit(:name, :text)
      params.require(:article).permit(:name)
    end

    def get_article name
      Article.where('lower(name) = ?', name.downcase).first
    end

    def get_category name
      Category.where('lower(name) = ?', name.downcase).first
    end
end
