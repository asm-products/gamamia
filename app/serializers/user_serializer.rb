class UserSerializer < ApplicationSerializer

  attributes :name, :avatar_url, :occupation

  def avatar_url
    if object.avatar_url.nil?
      avatar_path = Digest::MD5.hexdigest(object.email.downcase)
        "https://gravatar.com/avatar/#{avatar_path}.png?s=48&d=monsterid"
    else
      object.avatar_url
    end
  end

  def url
    nil
  end

end
