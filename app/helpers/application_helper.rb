module ApplicationHelper
  def extra_body_class(classname)
    content_for :body_class, 'cards-pf'
  end

  def tooltipped(title, options = {})
    options.deep_merge({
      title: title,
      data: {
        toggle: :tooltip
      }
    })
  end
end
