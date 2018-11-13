class Dessert < Dish
  has_many :guests, dependent: :nullify
end
