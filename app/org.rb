class Org
  attr_accessor :name

  def initialize(name, parent = Org.root)
    @name = name
    @parent = parent
    raise OrgHierarchyTooDeepError.new("too deep") if too_deep?
    @permissions = {}
  end


  def self.root
    @root ||= Org.new("Root Org", NullOrg)
  end

  def parent
    @parent
  end

  def role_for user
    @permissions[user] || parent.role_for(user)  
  end

  private

  def too_deep?
    return false if parent == NullOrg
    return false if parent == Org.root
    return false if parent.parent == Org.root
    true
  end

end

class NullOrg

  def self.role_for user
    :denied
  end

end

class OrgHierarchyTooDeepError < StandardError
end
