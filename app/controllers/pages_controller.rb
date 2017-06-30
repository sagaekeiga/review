class PagesController < ApplicationController
    
    def home
        @products = Product.all
        @ranks = Product.all.order("rank").first(10)
        @categories = Category.all.order("created_at").first(20)
    end
end
