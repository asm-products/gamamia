module UserHelper
  def avatar_for(user, size)
    return unless user
    avatar_url = if user.avatar_url.nil?
      avatar_path = Digest::MD5.hexdigest(user.email.downcase)
      if size == 'small'
        "https://gravatar.com/avatar/#{avatar_path}.png?s=48&d=monsterid"
      elsif size == 'large'
        "https://gravatar.com/avatar/#{avatar_path}.png?s=130&d=monsterid"
      end
    else
      if size == 'small'
        user.avatar_url
      elsif size == 'large'
        user.avatar_url.sub! 'normal', '400x400'
      end
    end

    link_to user, class: "block avatar" do
      if size == 'small'
        image_tag avatar_url, class: "block", width: "30", height: "30"
      elsif size == 'large'
        image_tag avatar_url, class: "block", width: "130", height: "130"
      end
    end
  end
end
