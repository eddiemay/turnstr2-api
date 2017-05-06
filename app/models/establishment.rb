class Establishment < User

  has_many :branches
  has_many :favourite_products
end
