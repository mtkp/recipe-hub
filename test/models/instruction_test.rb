require 'test_helper'

class InstructionTest < ActiveSupport::TestCase

  test "instruction attr" do
    instruction = Instruction.new
    assert instruction.invalid?
    assert instruction.errors[:body].any?
    assert instruction.errors[:position].any?
  end
end
