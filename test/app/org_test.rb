require_relative '../test_helper'

describe "#parent" do

  let(:root) { Org.root}
  let(:o1) { Org.new("org 1")}
  let(:co1) { Org.new("child org 1", o1)}

  it 'is root if not defined' do
    assert_equal root, o1.parent
  end

  it 'is org of child orgs' do
    assert_equal o1, co1.parent
  end

  it 'cannot have orgs below third level' do
    assert_raises (OrgHierarchyTooDeepError) { Org.new("grandchild org 1", co1 ) }
  end

end
