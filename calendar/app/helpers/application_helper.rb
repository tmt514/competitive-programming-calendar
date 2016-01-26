module ApplicationHelper
  def current_user
    if session[:user_id] == nil
      return nil
    end
    return User.find(session[:user_id])
  end

  def show_month_date(date)
    date.strftime('%m/%d')
  end

  def show_date(date)
    date.strftime('%Y-%m-%d')
  end

  OPTIONS = ['報名', '加一', '貢獻', '喇咧', '認領', '認領', '寫作', '跳痛', '好題', '認領',
             '耶呼', '撰寫', '招領', '認捐', '代筆', '提供', '贊助', '撰文', '認領', '認領',
             '認領', '比賽', '心得', '卡住', '編程', '代碼', '演算', '算法', '認領', '代碼',
             '認領', '輕鬆', '師說', '筆記', '心得', '是說', '新語', '學海', '無涯', '遊記']
  def hash_decoy_text(date)
    p = date.jd
    p = p * 19920401 % 40
    ApplicationHelper::OPTIONS[p]
  end

  require 'uri'
  def is_valid_url(url)
    return (url != nil and URI.encode(url) =~ /\A#{URI::regexp}\z/)
  end

  def is_before_the_end_of_today(date)
    return date <= Date.today()
  end

  def is_this_user_login(id)
    return (current_user != nil and current_user.id == id)
  end
end
