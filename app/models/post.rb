class Post < ApplicationRecord
    has_one_attached :image # This line enables image uploading
    has_many :post_tags
    has_many :tags, through: :post_tags
    has_many :post_categories
    has_many :categories, through: :post_categories
end
