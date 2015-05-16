class Org
  attr_accessor :name

  def initialize(name, parent = Org.root, policy = OrgDepthPolicy)
    @parent = parent
    policy.check_depth? self
    @name = name
    @permissions = {}
  end

  def self.root
    @root ||= Org.new("Root Org", NullOrg)
  end

  def add_admin user
    @permissions[user] = :admin
  end

  def add_user user
    @permissions[user] = :user
  end

  def add_denied user
    @permissions[user] = :denied
  end

  def visible_to? user
    return true if granted? user
    false
  end

  def granted? user
    if @permissions.key? user
      return [:admin, :user].include?( @permissions[user] )
    else
      return parent.granted? user
    end
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

  def self.granted? user
    false
  end

end

class OrgDepthPolicy
  def self.check_depth? org
    return if org.parent == NullOrg
    return if org.parent == Org.root
    return if org.parent.parent == Org.root
    raise OrgHierarchyTooDeepError.new("too deep") 
  end
end

class OrgHierarchyTooDeepError < StandardError
end
