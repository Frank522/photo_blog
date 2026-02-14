class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end

    def show
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to @article
        else
            render :new, status: :unprocessable_entity
        end
    end


    def edit
    end


    def update
        if @article.update!(article_params)
          redirect_to @article
        else
          render(:edit, status: :unprocessable_entity)
        end
    end

    def destroy
        @article.destroy
        respond_to do |format|
            format.html { redirect_to articles_url, notice: "Article was successfully destroyed.", status: :see_other }
        end
    end

    private
        def set_article
          @article = Article.find(params[:id])  
        end

        def article_params
            params.require(:article).permit(:title, :body, :status, :photo)
        end

        def authenticate
            authenticate_or_request_with_http_basic do |username, password|
                # In production, use environment variables for safety!
                username == Blog::Env.admin_user && password == Blog::Env.admin_password
            end
        end
end
