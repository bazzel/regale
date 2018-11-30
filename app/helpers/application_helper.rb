module ApplicationHelper
  def extra_body_class(classname)
    content_for :body_class, 'cards-pf'
  end
end
