require 'rails_helper'

RSpec.describe Platform do
  it 'sets id and name' do
    platform = Platform.new("my Platform")

    expect(platform.id).to eq("my Platform")
    expect(platform.name).to eq("my Platform")
  end
end
