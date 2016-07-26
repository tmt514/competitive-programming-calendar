class Challenge < ActiveRecord::Base
  has_many :challengestatuses
  belongs_to :user
  belongs_to :entry
end
