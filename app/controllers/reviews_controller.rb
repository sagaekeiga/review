class ReviewsController < ApplicationController
    http_basic_authenticate_with name: "sagae", password: "s19930528"

    
    def index
      @q        = Review.search(params[:q])
      @reviews = @q.result(distinct: true)
    end
    
    def destroy
      @review = Review.find(params[:id])
        if @review.delete
         flash[:success] = "deleted"
        end
        redirect_to pages_manage_path
    end

    
      private
      
        def review_params
          params.require(:review).permit(:date, :tweet_id, :name, :text, :url)
        end
end
