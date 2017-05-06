class FavouriteProduct < ApplicationRecord
  belongs_to :establishment, foreign_key: :user_id
  belongs_to :product
end
