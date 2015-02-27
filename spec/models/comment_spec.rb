require 'rails_helper'

RSpec.describe Comment do
  let(:comment) { Fabricate :comment }

  it "should save children" do
    child_comment = Fabricate(:comment)
    comment.children << child_comment
    expect(comment.reload.children).to eq([child_comment])
  end

  it "should save parent" do
    child_comment = Fabricate(:comment)
    child_comment.parent = comment
    child_comment.save
    expect(child_comment.reload.parent).to eq(comment)
  end
end
