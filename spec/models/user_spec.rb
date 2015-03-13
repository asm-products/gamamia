require 'rails_helper'

RSpec.describe User do
  it { should validate_presence_of(:username)}
  it { should validate_uniqueness_of(:username)}
  it { should allow_value("email@addresse.foo").for(:email) }
  it { should_not allow_value("foo@asdf").for(:email) }
end
