require_relative '../test_helper'

describe "kata structure" do

  let(:root) { Org.root}

  let(:o1) { Org.new("org 1")}
  let(:o2) { Org.new("org 2")}
  let(:o3) { Org.new("org 3")}
  let(:o4) { Org.new("org 4")}

  let(:co1) { Org.new("child org 1", o1)}
  let(:co2) { Org.new("child org 2", o1)}
  let(:co3) { Org.new("child org 3", o3)}
  let(:co4) { Org.new("child org 4", o3)}

  let(:ally) { User.new('Ally') }


  #this is my assumption on the kata
  it 'role defaults to denied if unspecified' do
    assert_equal :denied, root.role_for(ally)
    assert_equal :denied, o1.role_for(ally)
    assert_equal :denied, co1.role_for(ally)
    assert_equal :denied, co2.role_for(ally)
  end

  it 'roles filter down to children for all roles' do
    o1.add_admin ally
    assert_equal :admin,  o1.role_for(ally)
    assert_equal :admin,  co1.role_for(ally)
    assert_equal :admin,  co2.role_for(ally)

    o1.add_user ally
    assert_equal :user,  o1.role_for(ally)
    assert_equal :user,  co1.role_for(ally)
    assert_equal :user,  co2.role_for(ally)

    o1.add_denied ally
    assert_equal :denied,  o1.role_for(ally)
    assert_equal :denied,  co1.role_for(ally)
    assert_equal :denied,  co2.role_for(ally)
  end

  it 'roles filter to children but can be overridden' do
    root.add_user ally
    co2.add_denied ally

    assert_equal :user, o1.role_for(ally)
    assert ally.can_see? o1

    assert_equal :user, co1.role_for(ally)
    assert ally.can_see? co1

    assert_equal :denied, co2.role_for(ally)
    refute ally.can_see? co2
  end

  it 'user cannot see any orgs by default' do
    [root, o1, o2, o3, o4, co1, co2, co3, co4].each do |org|
      refute ally.can_see? org 
    end
  end

  it 'roles are implicitly inherited' do
    root.add_admin ally
    [root, o1, o2, o3, o4, co1, co2, co3, co4].each do |org|
      assert ally.can_see? org 
    end
  end

end
