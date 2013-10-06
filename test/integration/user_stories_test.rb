require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :users

  test "signing up, signing in, and editing account settings" do
    User.delete_all

    # a user visits the root page
    get '/'
    assert_response :success
    assert_template "static_pages/home"

    assert_select ".navbar-btn", "Sign in"
    assert_select "a", "Sign up!"
    assert_select "a", { text: "Sign out", count: 0 }

    get sign_up_path
    assert_response :success
    assert_template "devise/registrations/new"

    # ( post via redirect will follow the actions until a
    #   nonredirect response is returned )

    # the user signs up
    post_via_redirect "/users",
                      user: { email: "new.guy@email.co.jp",
                              username: "new_guy",
                              password: "my1password",
                              password_confirmation: "my1password" }
    assert_response :success
    assert_template "users/show"
    assert_select ".alert-success", "Welcome! You have signed up successfully."
    assert_select "h6", "new_guy"
    assert_select "h6", "new.guy@email.co.jp"

    # the user edits their email and username
    get 'users/edit'
    assert_response :success
    patch_via_redirect "/users",
                       user: { email: "new.guy.2@email.co.jp",
                               username: "new_guy_2",
                               current_password: "my1password" }
    assert_response :success
    assert_template "users/show"
    assert_select ".alert-success", "You updated your account successfully."
    assert_select "h6", "new_guy_2"
    assert_select "h6", "new.guy.2@email.co.jp"

    get "/new_guy_2"
    assert_response :success
    assert_template "users/show"
    assert_select ".alert-success", false
    assert_select "h6", "new_guy_2"
    assert_select "h6", "new.guy.2@email.co.jp"

    # user signs out
    get_via_redirect "/sign_out"
    assert_response :success
    assert_template "static_pages/home"
    assert_select ".alert-success", "Signed out successfully."

    get "/new_guy_2"
    assert_response :redirect
    get_via_redirect "/new_guy_2"
    assert_select ".alert-danger", "You need to sign in or sign up before continuing."

    # user decides to sign back in, but with old email
    get sign_in_path
    assert_response :success
    assert_template "devise/sessions/new"
    post_via_redirect "/users/sign_in",
                      user: { email: "new.guy@email.co.jp",
                              password: "my1password" }
    assert_response :success
    assert_template "devise/sessions/new"
    assert_select ".alert-danger", "Invalid email or password."

    # user signs in with correct email (new email)
    post_via_redirect "/users/sign_in",
                      user: { email: "new.guy.2@email.co.jp",
                              password: "my1password" }
    assert_response :success
    assert_template "users/show"
    assert_select ".alert-success", "Signed in successfully."
    assert_select "h6", "new_guy_2"
    assert_select "h6", "new.guy.2@email.co.jp"
  end

  # test "buying a product" do
  #   LineItem.delete_all
  #   Order.delete_all
  #   ruby_book = products(:ruby)

  #   # a user goes to the store index page
  #   get '/'
  #   assert_response :success
  #   assert_template "index"

  #   # they select a product and add it to the cart
  #   # ( submit 'post' actions to line items controller,
  #   #   with params[product_id] = ruby_book.id )
  #   xml_http_request :post, '/line_items', product_id: ruby_book.id
  #   assert_response :success

  #   cart = Cart.find(session[:cart_id])
  #   assert_equal 1, cart.line_items.size
  #   assert_equal ruby_book, cart.line_items[0].product

  #   # they then check out
  #   get "/orders/new"
  #   assert_response :success
  #   assert_template "new"

  #   # ( post via redirect will follow the actions until a
  #   #   nonredirect response is returned )
  #   post_via_redirect "/orders",
  #                     order: { name: "Dave Thomas",
  #                              address: "123 The Street",
  #                              email: "dave@example.com",
  #                              pay_type: "Check" }
  #   assert_response :success
  #   assert_template "index"
  #   cart = Cart.find(session[:cart_id])
  #   assert_equal 0, cart.line_items.size

  #   # check database for the order
  #   orders = Order.all
  #   assert_equal 1, orders.size
  #   order = orders[0]

  #   assert_equal "Dave Thomas", order.name
  #   assert_equal "123 The Street", order.address
  #   assert_equal "dave@example.com", order.email
  #   assert_equal "Check", order.pay_type

  #   assert_equal 1, order.line_items.size
  #   line_item = order.line_items[0]
  #   assert_equal ruby_book, line_item.product

  #   # ensure mail is generated properly
  #   mail = ActionMailer::Base.deliveries.last
  #   assert_equal ["dave@example.com"], mail.to
  #   assert_equal ["depot@example.com"], mail.from
  #   assert_equal "Pragmatic Store Order Confirmation", mail.subject
  # end
end
