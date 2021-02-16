class User < ActiveRecord::Base
  has_many :posts
  validates :username, presence: true
  validates :email, presence: true
  validates :username, uniqueness: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  after_create { FakeMailer.instance.mail(email, 'Welcome to HN!') }
  def email=(value)
    self[:email] = value.to_s.strip
  end
end
