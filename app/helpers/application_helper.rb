module ApplicationHelper
    #Change active class for dashboard menu
    def current_class_by(path:)
        return "active" if request.path == path 
    end
end
