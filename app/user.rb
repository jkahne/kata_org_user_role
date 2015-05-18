class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def can_see? org
    org.granted? self
  end
end
