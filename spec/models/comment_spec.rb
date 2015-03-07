require 'rails_helper'

RSpec.describe Comment do
  let(:comment){ Fabricate :comment }
  let(:user) { Fabricate :user }
  let(:mention_comment){ Fabricate :comment, user: user, content: "Hello @#{user.username}. nice to meet you" }

  before { ActionMailer::Base.deliveries = [] }

  it "should deliver email" do
    expect{ mention_comment }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it "should not deliver email if User#email_notifications is false" do
    user.update(email_notifications: false)

    expect{ mention_comment }.to_not change{ ActionMailer::Base.deliveries.count }.from(0)
  end

  it "should cache html output" do
    mention_comment
    expect(mention_comment.reload.cached_content).to match /<a.*href=".*\/users\/#{user.username}".*>@#{user.username}<\/a>/
  end
end
