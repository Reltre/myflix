module CategoriesHelper
  def format_name(name)
    name.gsub(' ', '_')
  end
end
