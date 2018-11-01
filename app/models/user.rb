class User < ApplicationRecord
  def anonymous?
    false
  end
end

class NullUser
  def anonymous?
    true
  end

  def id
    nil
  end
end
