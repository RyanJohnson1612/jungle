class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: { case_sensitive: false },
                    presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 6}

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email)

    user && user.authenticate(password) ? user : nil
  end
end
