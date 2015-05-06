require 'rails_helper'

RSpec.describe GamePlatform, type: :model do
  it { should belong_to(:game) }
  it { should belong_to(:platform) }
end
