class UserMailer < ApplicationMailer
  def game_scheduled(game)
    @user = game.user
    @game = game
    return if @user.is_admin?
    mail(to: @user.email, subject: "Your game #{@game.title} has been accepted") do |format|
    	format.html { render layout: 'mailer.html.erb'}
    	format.text
    end
  end
end
