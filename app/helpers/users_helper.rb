module UsersHelper
  # Returns the Gravatar for a given email
  # (http://gravatar.com/)
  def gravatar_for(user, options = { size: 120 }) 
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "img-rounded",
              width: size, height: size)
  end
end
