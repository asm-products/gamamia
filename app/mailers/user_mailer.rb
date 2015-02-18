class UserMailer < ApplicationMailer
  def game_scheduled(game)
    @user = game.user
    @game = game
    return if @user.is_admin?
    mail(to: @user.email, subject: "Your game #{@game.title} has been accepted")
  end
end
