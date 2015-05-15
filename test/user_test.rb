require_relative 'test_helper'

describe User do
  it 'should keep name' do
    user = User.new 'bob'
    assert_equal 'bob', user.name
  end
end
