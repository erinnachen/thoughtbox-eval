class Link < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true
  validates :url, :url => true

  belongs_to :user
  def status
    return "read" if read
    "unread"
  end
end
