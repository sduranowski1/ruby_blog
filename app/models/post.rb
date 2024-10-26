class Post < ApplicationRecord
    has_one_attached :image # This line enables image uploading
end
