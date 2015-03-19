module LoginHelpers
  def sign_in_as(user)
    visit root_path
    prepare_omniauth(user)
    click_link_or_button "Login / Signup"
    finish_signup
  end

  def sign_out
  end

  private

  def finish_signup
    fill_in 'user_username', with: 'twitter_test_user'
    fill_in 'user_email', with: 'twitter@example.com'
    fill_in 'user_occupation', with: 'developer'
    click_link_or_button "Continue"
  end

  def prepare_omniauth(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:twitter, fake_twitter_response)
  end

  def fake_twitter_response
    {
      :provider => "twitter",
      :uid => "123456",
      :info => {
        :nickname => "johnqpublic",
        :name => "John Q Public",
        :location => "Anytown, USA",
        :image => "http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png",
        :description => "a very normal guy.",
        :urls => {
          :Website => nil,
          :Twitter => "https://twitter.com/johnqpublic"
        }
      },
      :credentials => {
        :token => "a1b2c3d4...", # The OAuth 2.0 access token
        :secret => "abcdef1234"
      },
      :extra => {
        :access_token => "", # An OAuth::AccessToken object
        :raw_info => {
          :name => "John Q Public",
          :listed_count => 0,
          :profile_sidebar_border_color => "181A1E",
          :url => nil,
          :lang => "en",
          :statuses_count => 129,
          :profile_image_url => "http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png",
          :profile_background_image_url_https => "https://twimg0-a.akamaihd.net/profile_background_images/229171796/pattern_036.gif",
          :location => "Anytown, USA",
          :time_zone => "Chicago",
          :follow_request_sent => false,
          :id => 123456,
          :profile_background_tile => true,
          :profile_sidebar_fill_color => "666666",
          :followers_count => 1,
          :default_profile_image => false,
          :screen_name => "",
          :following => false,
          :utc_offset => -3600,
          :verified => false,
          :favourites_count => 0,
          :profile_background_color => "1A1B1F",
          :is_translator => false,
          :friends_count => 1,
          :notifications => false,
          :geo_enabled => true,
          :profile_background_image_url => "http://twimg0-a.akamaihd.net/profile_background_images/229171796/pattern_036.gif",
          :protected => false,
          :description => "a very normal guy.",
          :profile_link_color => "2FC2EF",
          :created_at => "Thu Jul 4 00:00:00 +0000 2013",
          :id_str => "123456",
          :profile_image_url_https => "https://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png",
          :default_profile => false,
          :profile_use_background_image => false,
          :entities => {
            :description => {
              :urls => []
            }
          },
          :profile_text_color => "666666",
          :contributors_enabled => false
        }
      }
    }
  end
end
