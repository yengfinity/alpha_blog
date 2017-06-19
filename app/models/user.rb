class User < ActiveRecord::Base

  has_many :articles, dependent: :destroy

  before_save { self.email = email.downcase } #before a save/commit to db, it takes its email and downcase it

  validates :username, presence: true, uniqueness: { case_sensitive: false },
            length: { mininum: 3, maximum: 25 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 105 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }

  has_secure_password
end