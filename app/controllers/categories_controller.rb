class CategoriesController < ApplicationController

    
    def index
      @q        = Category.search(params[:q])
      @categories = @q.result(distinct: true)
      @category = Category.new
    end
    
    def create
     @category = Category.new(category_params)
     if @category.save
       redirect_to categories_path
     else
       render 'categories/index'
     end
    end
    
    def destroy
      @category = Category.find(params[:id])
        if @category.delete
         flash[:success] = "deleted"
        end
        redirect_to categories_path
    end
    
    def update
        @category = Category.find(params[:id])
        @category.update(category_params)
        redirect_to categories_path
    end

    
      private
      
        def category_params
          params.require(:category).permit(:name, :description)
        end
end
