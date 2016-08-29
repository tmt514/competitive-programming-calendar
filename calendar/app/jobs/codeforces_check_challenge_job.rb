class CodeforcesCheckChallengeJob < ActiveJob::Base
  queue_as :default
  
  before_enqueue do |job|
    puts "2ENQUEUE!!!!!!!"
  end

  after_perform do |job|
    puts "2JOB FINIHSED!!!!"
  end

  def perform(*args)
    challenge = args[0]
    user = args[1]

    if challenge.oj != "cf"
      return
    end

    profile = user.userprofiles.where(name: 'Handle:CF').first
    if profile == nil
      return
    end

    handle = profile.value

    s = /^(\d*)(\w\w*)$/.match(challenge.pid)
    contest = s[1]
    index = s[2]
    challengestatus = user.challengestatuses.where(challenge: challenge).first || Challengestatus.new(user: user, challenge: challenge)
    if challengestatus.status == 'OK'
      return
    end

    res = HTTP.get("http://codeforces.com/api/contest.status?contestId=#{contest}&handle=#{handle}&from=1&count=10").to_s
    res = JSON.parse(res)
    if res['status'] == "OK"
      res['result'].each do |result|
        if result['problem']['index'] == index and result['verdict'] == 'OK'
          challengestatus.status = "OK"
          challengestatus.save!
          break
        end
      end
    end
    
  end
end
