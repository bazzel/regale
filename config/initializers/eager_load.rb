if Rails.env.development? || Rails.env.test?
  # To make `Dish.descendants` work.
  Rails.application.config.eager_load_paths = Rails.root.join('app/models')
  Rails.application.reloader.to_prepare do
    Dir[Rails.root.join('app/models/*.rb')].each {|file| require_dependency file}
  end
end
