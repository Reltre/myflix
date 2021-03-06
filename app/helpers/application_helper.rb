module ApplicationHelper
  def options_for_video_reviews(selected = nil)
    options = [5,4,3,2,1].map { |number| [pluralize(number, "Star"), number] }
    options_for_select(options, selected)
  end
end
