require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test "valid tag attrs" do
    tag = Tag.new
    assert tag.invalid?
    assert tag.errors[:name].any?
  end

  test "dont allow recreation of existing tags" do
    tag = Tag.new(name: "yummy")
    
    assert tag.valid?
    tag.save

    tag = Tag.new(name: "yummy")
    assert tag.invalid?
  end

  test "tag is stripped of whitespace" do
    tag = Tag.new(name: " my new tag  ")
    assert tag.valid?
    assert_equal "my new tag", tag.name
  end

  test "tags are saved lowercase only" do
    tag = Tag.new(name: "HEY")
    assert tag.valid?
    assert_equal "hey", tag.name

    tag1 = Tag.new(name: "HELLO")
    tag1.save

    tag2 = Tag.new(name: "heLLo")
    assert tag2.invalid?
  end

end
