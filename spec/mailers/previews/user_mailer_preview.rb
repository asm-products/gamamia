class UserMailerPreview < ActionMailer::Preview

  def mentioned
    user = User.first
    comment = Comment.first
    UserMailer.mentioned(user, comment)
  end
end
