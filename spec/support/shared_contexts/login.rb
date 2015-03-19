RSpec.shared_context "with user logged in" do
  let!(:user) { Fabricate(:user) }

  background do
    sign_in_as(user)
  end
end
