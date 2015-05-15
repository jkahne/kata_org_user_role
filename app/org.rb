class Org
  attr_accessor :name

  def initialize(name, parent = Org.root)
    @name = name
    @parent = parent
    raise OrgHierarchyTooDeepError.new("too deep") if too_deep?
  end


  def self.root
    @root ||= Org.new("Root Org", nil)
  end

  def parent
    @parent
  end

  private

  def too_deep?
    return false if parent == nil
    return false if parent != nil && parent == Org.root
    return false if parent.parent != nil &&  parent.parent == Org.root
    true
  end

end

class OrgHierarchyTooDeepError < StandardError
end
