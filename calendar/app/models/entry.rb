class Entry < ActiveRecord::Base
  belongs_to :user 
  has_many :challenges
  scope :blogs, -> { where(status: 'blog') }
  scope :events, -> { where(status: 'event') }
end
