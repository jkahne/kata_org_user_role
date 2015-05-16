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


end
