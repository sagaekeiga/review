class PagesController < ApplicationController
    
    def home
        @q        = Product.search(params[:q])
        @products = Product.all
        @ranks = Product.all.order("rank").reverse.first(10)
        @categories = Category.all.order("created_at").first(20)
        @comments = Comment.all.order("created_at").reverse.first(20)
    end
end
