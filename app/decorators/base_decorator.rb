# Base decorator. All other decorator will inherit from this
class BaseDecorator < SimpleDelegator
  def decorate(model, decorate_class = nil)
    ApplicationController.helpers.decorate(model, decorate_class)
  end

  # Use for all models
  def formatted_date(date)
    date.strftime("%d %b %Y")
  end
end
