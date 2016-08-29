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


  def parse_ojpid(ojpid)
    #input is a string
    if (/^CF(\d*)(\w\w*)$/ =~ ojpid) != nil
      s = /^CF(\d*)(\w\w*)$/.match(ojpid)
      info = {
        oj: 'cf',
        pid: s[1] + s[2],
        contestId: s[1],
        index: s[2]
      }
      return info
    end
    return nil
  end

  def training
    topic = params.fetch(:topic, "")
    if topic == 'data-structures'
      if Rails.env.production?
        @list = YAML.load_file('/sqlite-data/training/data-structures.yml')
      else
        @list = YAML.load_file('db/training/data-structures.yml')
      end
    end

    @list.each do |stage|
      stage['challenges'].each do |prob|
        ojpid = prob['pid']
        info = parse_ojpid(ojpid)
        cha = Challenge.where(pid: info[:pid], oj: info[:oj]).first
        if !cha
          info[:title] = quick_get_title(s[1], s[2])
          cha = Challenge.new(info)
          cha.save!
        end
        prob[:data] = cha
      end
    end
    @list.reverse!

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


  def quick_get_title(contestId, index)
    # internal use
    page = HTTP.get("http://www.codeforces.com/problemset/problem/#{contestId}/#{index}").body.to_s
    t = Nokogiri::HTML(page)
    title = t.css('div.header div.title')[0].child.to_s
    return title[3..-1]
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
