class Org
  attr_accessor :name

  def initialize(name, parent = Org.root)
    @name = name
    @parent = parent
  end

  def self.root
    @root ||= Org.new("Root Org", nil)
  end

  def parent
    @parent
  end

end
