#if Rails.env.development?
%w(soup appetizer main_course dessert).each do |c|
  c.classify.constantize
  #require_dependency File.join("app","models","#{c}.rb")
end
#end
