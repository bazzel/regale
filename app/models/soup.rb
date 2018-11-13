class Soup < Dish
  has_many :guests, dependent: :nullify
end
