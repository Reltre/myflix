module Tokenable
  def generate_token!
    update_attribute(:token, SecureRandom.urlsafe_base64)
  end
end
