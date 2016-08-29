module ChallengeHelper
  def oj(oj)
    return "Codeforces" if oj == "cf"
    return "X"
  end

  def gen_link(cha)
    url = "#"
    if cha.oj == "cf"
      s = /^(\d*)(\w\w*)$/.match(cha.pid)
      url = "http://www.codeforces.com/problemset/problem/#{s[1]}/#{s[2]}"
    end
    return url
  end

  def challenge_info(cha)
    icon_trophy = "<i class='icon trophy'></i>"
    if session[:user_id] != nil
      user = User.find(session[:user_id])
      if user.challengestatuses.where(challenge: cha).first == nil
        CodeforcesCheckChallengeJob.perform_later(cha, user)
      else
        icon_trophy = "<i class='icon checkmark icon-success'></i>"
      end
    end
    return "<div class='challenge' data-challenge='y' data-challenge-id='#{cha.id}'>" +
           icon_trophy + 
           "<span>(#{cha.points} pts) " +
           "<a href='#{gen_link(cha)}' target='blank'>" +
           "#{oj(cha.oj)} #{cha.pid} - #{cha.title}" +
           "</a></span>" +
           "</div>"
  end
end
