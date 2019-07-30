class User < ApplicationRecord
  # Encrypts Password
  has_secure_password


  validates_presence_of :name, :email, :password_digest

end
