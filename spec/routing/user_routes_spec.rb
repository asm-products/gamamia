require "rails_helper"

RSpec.describe "routes for Users", :type => :routing do
  let(:user) { Fabricate(:user) }
  it "routes /users/test/finish_signup to Users#finish_signup" do
    expect(get("/users/test/finish_signup")).to route_to("users#finish_signup", id: "test")
  end

  it "routes finish_signup_path to slug path" do
    expect(:get => finish_signup_path(user)).
      to route_to("users#finish_signup", id: user.username)
  end
end
