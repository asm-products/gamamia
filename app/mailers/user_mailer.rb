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

def mentioned(user, comment)
    @user = user
    @comment = comment
    mail(to: @user.email, subject: "You have been mentioned at gamamia.com") do |format|
      format.html { render layout: 'mailer.html.erb'}
      format.text
    end
  end
end
