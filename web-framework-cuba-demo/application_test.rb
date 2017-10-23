require 'cuba/test'
require_relative 'application'

scope do
  test "home page" do
    get '/'
    follow_redirect!
    assert_equal 'hello cuba', last_response.body
  end
end
