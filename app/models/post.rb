class Post < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  validates :title, length: { minimum: 5 }
  validates :title, uniqueness: { case_sensitive: false }
  validates :url, presence: true
  validates :url, format:
    { with: /\A(http|https):\/\/[a-z0-9]+([\-.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ }
  validates :user, presence: true
  scope :all_desc_votes, -> { order(votes: :desc) }
end
