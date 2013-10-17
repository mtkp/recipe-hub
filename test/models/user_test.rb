require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "valid user (attrs)" do
    user = User.new
    assert user.invalid?
    assert user.errors[:username].any?
    assert user.errors[:email].any?
    assert user.errors[:password].any?
  end

  def new_user(username)
    User.new(username: username,
             email: "test@example.com",
             password: "password",
             password_confirmation: "password")
  end

  test "username attr format" do
    ok_usernames = [ "person", "_person_", "____k____", "per_son", "EXAMPLE", "guy"]

    bad_usernames = [ "___", ("a" * 21), "abc!", "ab-c", "a*c", '!@#$%^&*()',
                      "a", "aa" ]

    reserved_path_words = [ "user", "username", "recipe", "ingredient",
                           "direction", "fork", "star", "devise", "sign_in",
                           "sign_out", "sign_up", "tag", "tagging", "search" ]

    ok_usernames.each do |name|
      assert new_user(name).valid?, "#{name} should be valid"
    end

    bad_usernames.each do |name|
      assert new_user(name).invalid?, "#{name} should be invalid"
    end

    reserved_path_words.each do |name|
      assert new_user(name).invalid?, "#{name} should be invalid"
      assert new_user("#{name}s").invalid?, "#{name}s should be invalid"
      assert new_user(name.upcase).invalid?, "#{name.upcase} should be invalid"
    end
  end

  test "username attr uniqueness" do
    bob1 = new_user("bobby_test")
    bob1.save

    # case-insensitive uniqueness
    bob2 = new_user("BOBBY_TEST")
    assert bob2.invalid?
    
    # bob1 deletes his account
    bob1.destroy
    assert bob2.valid?
    
    # bob2's username is saved lowercase
    bob2.save
    assert_equal "bobby_test", bob2.username
  end

end

