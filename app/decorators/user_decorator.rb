#Decorator for users. It decorates a model instance and allows to extract complex logic from the views
class UserDecorator < BaseDecorator

  def full_name
    "#{first_name} #{last_name}"
  end

  def user_role
    admin ?  "Administrator" : "Staff"
  end

  def limit
    (travel_limit && !travel_limit.empty?) ? "€#{travel_limit}" : "No Limit"
  end

end
