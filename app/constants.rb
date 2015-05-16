class Constants
  def self.roles
    [:admin, :user, :denied]
  end

  def self.grantable_roles
    [:admin, :user]
  end

  def self.default_role
    :denied
  end
end
