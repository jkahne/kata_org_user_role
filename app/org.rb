class Org

  attr_accessor :name
  attr_reader :permission, :parent

  extend Forwardable

  def_delegators :permission, :role_for, :visible_to?, :granted?, :add_admin, :add_user, :add_denied

  def initialize(name, parent = Org.root, policy = OrgDepthPolicy)
    @parent = parent
    policy.check_depth! self
    @name = name
    @permission = Permission.new(self)
  end

  def self.root
    @root ||= Org.new("Root Org", NullOrg)
  end
end


class NullOrg
  def self.role_for user
    Constants.default_role
  end
  def self.granted? user
    false
  end
end


class OrgDepthPolicy
  def self.check_depth! org
    return if org.parent == NullOrg
    return if org.parent == Org.root
    return if org.parent.parent == Org.root
    raise OrgHierarchyTooDeepError.new("too deep") 
  end
end


class OrgHierarchyTooDeepError < StandardError
end
