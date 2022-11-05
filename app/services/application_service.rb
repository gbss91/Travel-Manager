#Simplify services call. Used in all services
class ApplicationService
  def self.call(*args)
    new(*args).call
  end

end