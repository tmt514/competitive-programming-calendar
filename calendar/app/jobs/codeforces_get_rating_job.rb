require "http"

class CodeforcesGetRatingJob < ActiveJob::Base
  queue_as :default

  before_enqueue do |job|
    puts "ENQUEUE!!!!!!!"
  end

  after_perform do |job|
    puts "JOB FINIHSED!!!!"
  end

  def perform(*args)
    user = args[0]

    profile = user.userprofiles.where(name: 'Handle:CF').first
    if profile == nil
      return
    end

    handle = profile.value
    res = HTTP.get('http://codeforces.com/api/user.info?handles=' + handle).to_s
    res = JSON.parse(res)
    if res['status'] == "OK"
      rank = res['result'][0]['rank']
      rating = res['result'][0]['rating']
      rankprofile = user.userprofiles.where(name: 'CF:rank').first || Userprofile.new(name: 'CF:rank', user: user)
      rankprofile.value = rank
      rankprofile.save!
      ratingprofile = user.userprofiles.where(name: 'CF:rating').first || Userprofile.new(name: 'CF:rating', user: user)
      ratingprofile.value = rating
      ratingprofile.save!
    end
  end
end
