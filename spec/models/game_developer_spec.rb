require 'rails_helper'

RSpec.describe GameDeveloper do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:location) }

  it { should have_many(:games) }
end
