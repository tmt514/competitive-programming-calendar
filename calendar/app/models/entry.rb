class Entry < ActiveRecord::Base
  belongs_to :user 
  scope :blogs, -> { where(status: 'blog') }
  scope :events, -> { where(status: 'event') }
end
