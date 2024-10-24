# Main application helper
module ApplicationHelper
  # Change active class for dashboard menu
  def current_class_by(path:)
    "active" if request.path == path
  end

  # Decorator helper - Initialises the decorator class
  def decorate(model, decorate_class = nil)
    (decorate_class || "#{model.class}Decorator".constantize).new(model)
  end
end
