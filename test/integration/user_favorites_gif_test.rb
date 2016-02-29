require 'test_helper'

class UserFavoritesGifTest < ActionDispatch::IntegrationTest
  def test_user_can_favorite_gif
    user = User.create(username: "adam",
                        password: "password",
                        role: 0)

    gif = Gif.create(image_url: "www.test.com", category: "Test")

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit gifs_path

    click_link_or_button "Test"
    check "Favorite"

    assert page.has_content?("Test")

    assert_equal "/gifs/#{gif.id}", current_path
  end
end
