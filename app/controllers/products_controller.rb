class ProductsController < ApplicationController
require 'uri'

    
    def index
        @products = Product.all
        @product = Product.new
    end

    
    def create
     @product = Product.new(product_params)
     if @product.save
       redirect_to products_path
     else
        @products = Product.all
       render 'products/index'
     end
    end
    
    def edit
      @q        = Product.search(params[:q])
      @product = Product.find(params[:id])
    end
    
    def destroy
      @product = Product.find(params[:id])
        if @product.delete
         flash[:success] = "deleted"
        end
        redirect_to products_path
    end
    
    def show
      @q        = Product.search(params[:q])
      @product = Product.find(params[:id])
      @product.rank = @product.rank + 1
      @product.save!
      @reviews = Review.where(product: "#{@product.name}")
    end
    
    def update
        @product = Product.find(params[:id])
        @product.update(product_params)
        redirect_to products_path
    end
    
    
    
    def scraping
      @products = Product.where(switch: "オン")
      puts "#{@products.count}"
      config = {
      	:consumer_key => 'HxTbIelBlbjp56cERilNt6XEy',
      	:consumer_secret => 'mzrDSM4WkFC23cx1TRQPrQ4p2AT0Yt1RxYpojAcD5Ua7RZZPWA',
      	:access_token => '732909452563619845-ptSOidEhCvXBPGCWUF6KoOqrFRcJAJ4',
      	:access_token_secret => 'x7m24zjdrJyhe1w8dmt5paIPEgfnSTmrCjLXJ8CnASjQd'
      }
      
      @twClient = Twitter::REST::Client.new(config)
      
      @products.each do |product|
          # word を含む tweet を 10 件取得する
          results = @twClient.search(product.name, :count => 20, :result_type => "recent", :include_entities => true)
          results.take(100).each do |tweet|
              tweet.media.each do |media| #画像付きのツイート取得
                  begin
                      @review = Review.new
                      @review.tweet_id = tweet[:id]
                      @review.date = tweet[:created_at].strftime("%Y-%m-%d %H:%M:%S")
                      @review.product = product.name
                      @review.name = "@" + tweet[:user][:screen_name]
                      @review.text = tweet[:text]
                      URI.extract(@review.text).uniq.each{|url|
                          @review.text.gsub!(url,"")
                      }
                      @review.url = media.media_url if !media.nil?
                      @review.save!
                  rescue => e
                        p "エラー"
                  end
              end
                  begin
                      @review = Review.new
                      @review.tweet_id = tweet[:id]
                      @review.date = tweet[:created_at].strftime("%Y-%m-%d %H:%M:%S")
                      @review.product = product.name
                      @review.name = "@" + tweet[:user][:screen_name]
                      @review.text = tweet[:text]
                      @review.save!
                  rescue => e
                        p "エラー"
                  end  
          end
      end
      
      redirect_to products_path
    end

    
      private
      
        def product_params
          params.require(:product).permit(:name, :description, :switch, :category, :url)
        end
end