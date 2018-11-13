class MainCourse < Dish
  has_many :guests, dependent: :nullify
end
