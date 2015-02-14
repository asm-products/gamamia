module ApplicationHelper

  def avatar(attrs={})
    user = attrs.fetch(:user)
    size = attrs.fetch(:size, 24)

    avatar_url = if user.avatar_url.nil?
      avatar_path = Digest::MD5.hexdigest(user.email.downcase)
        "https://gravatar.com/avatar/#{avatar_path}.png?s=#{size}&d=monsterid"
    else
      user.avatar_url
    end

    render partial: 'avatars/avatar',
            locals: {
              avatar_url: avatar_url,
              size: size,
              user: user,
            }
  end

  def icon(icon)
    render 'ui/icon', icon: icon
  end

  def format_date(date)
    "#{date.strftime("%B")} #{date.day.ordinalize}"
  end

end
