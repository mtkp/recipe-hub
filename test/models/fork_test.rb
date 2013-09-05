require 'test_helper'

class ForkTest < ActiveSupport::TestCase
  fixtures :recipes
  test "should be unique" do
    tacos = recipes(:tacos)
    pasta = recipes(:pasta)
    fork1 = Fork.new(source_id: tacos, fork_id: pasta)
    fork1.save

    fork2 = Fork.new(source_id: tacos, fork_id: pasta)
    assert fork2.invalid?
  end

  test "cannot_fork_self validation" do
    fork = Fork.new
    fork.source_id = fork.fork_id = recipes(:tacos)
    assert fork.invalid?
  end
end
