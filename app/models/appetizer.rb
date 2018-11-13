class Appetizer < Dish
  has_many :guests, dependent: :nullify
end
