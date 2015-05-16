class Permission
  def initialize(org)
    @org = org.parent
    @permissions = {}
  end

  def role_for user
    @permissions[user] || @org.role_for(user)  
  end

  def granted? user
    if @permissions.key? user
      return [:admin, :user].include?( @permissions[user] )
    else
      return @org.granted? user
    end
  end

  def visible_to? user
    return true if granted? user
    false
  end

  [:admin, :user, :denied].each do |meth|
    define_method("add_#{meth}") do |user| 
      @permissions[user] = meth
    end
  end
end
