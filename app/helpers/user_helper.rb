module UserHelper
  def avatar_for(user)
    return unless user
    avatar_url = if user.avatar_url.nil?
      avatar_path = Digest::MD5.hexdigest(user.email.downcase)
      "https://gravatar.com/avatar/#{avatar_path}.png?s=48&d=monsterid"
    else
      user.avatar_url
    end

    link_to "#", class: "block" do
      image_tag avatar_url, class: "block", width: "24", height: "24"
    end
  end
end
