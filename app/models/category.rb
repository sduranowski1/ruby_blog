class Category < ApplicationRecord
    has_many :post_categories
    has_many :posts, through: :post_categories
    
    # Method to count posts
    def post_count
        posts.count
    end
end
  