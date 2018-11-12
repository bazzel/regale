class AddCoursesToGuest < ActiveRecord::Migration[5.2]
  def change
    add_reference(:guests, :soup, foreign_key: {to_table: :dishes})
    add_reference(:guests, :appetizer, foreign_key: {to_table: :dishes})
    add_reference(:guests, :main_course, foreign_key: {to_table: :dishes})
    add_reference(:guests, :dessert, foreign_key: {to_table: :dishes})
  end
end
