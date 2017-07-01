namespace :sample do
  task :sample => :environment do
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
                      @review.image = tweet[:user][:profile_image_url]
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
                      @review.image = tweet[:user][:profile_image_url]
                      @review.save!
                  rescue => e
                        p "エラー"
                  end  
          end
      end
  end
end
