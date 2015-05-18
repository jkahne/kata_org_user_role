class Permission
  def initialize(org)
    @org = org
    @permissions = {}
  end

  def role_for user
    @permissions[user] || @org.parent_has_role_for(user)  
  end

  def granted? user
    if permission_defined_at_this_level? user
      return permission_granted? user
    else
      return permission_defined_at_parent? user
    end
  end

  Constants.roles.each do |meth|
    define_method("add_#{meth}") do |user|
      @permissions[user] = meth
    end
  end

  private

  def permission_defined_at_this_level? user
    @permissions.key? user
  end

  def permission_defined_at_parent? user
    @org.parent_granted? user
  end

  def permission_granted? user
    Constants.grantable_roles.include?( @permissions[user] )
  end

end
