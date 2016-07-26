class ChallengeController < ApplicationController

  def show
    if session[:user_id] == nil
      return redirect_to root_path
    end

    if user.role != 'admin'
      return head 403
    end

    @entries = Entry.blogs.order(target: :desc).all

  end


  def ajax_create
    if session[:user_id] == nil
      return head 403
    end

    # user = User.find(session[:user_id])
    c = get_challenge
    
    entry = Entry.find(c[:entry_id])
    if !entry or (user.role != 'admin' and user != entry.user)
      return head 403
    end

    challenge = Challenge.new(user: user)
    challenge.update!(c)
    return render json: challenge
  end


  def ajax_cf_get_title
    if session[:user_id] == nil
      return head 403
    end

    if user.role != 'admin'
      return head 403
    end

    pid = params.fetch(:pid, "")
    if (/^\d*\w\w*$/ =~ pid) == nil
      return render plain: ""
    end

    s = /^(\d*)(\w\w*)$/.match(pid)
    contestId = s[1]
    index = s[2]
    page = HTTP.get("http://www.codeforces.com/problemset/problem/#{contestId}/#{index}").body.to_s
    t = Nokogiri::HTML(page)
    title = t.css('div.header div.title')[0].child.to_s
    return render plain: title[3..-1]
  end
  
  def get_challenge
    params.fetch(:challenge, {}).permit(:entry_id, :oj, :pid, :title, :points)
  end


  def user
    User.find(session[:user_id])
  end
end
