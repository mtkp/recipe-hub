require 'test_helper'

class StarTest < ActiveSupport::TestCase
  test "valid star (attrs)" do
    star = Star.new
    assert star.invalid?
    assert star.errors[:user_id].any?
    assert star.errors[:recipe_id].any?
  end
end
