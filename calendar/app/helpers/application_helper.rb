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
             '耶呼', '撰寫', '以文', '招領', '認捐', '代筆', '提供', '贊助', '撰文', '認領',
             '認領', '比賽', '心得', '卡住', '序可', '可魚', '編程', '代碼', '演算', '算法',
             '認領', '輕鬆', '笑點', '師說', '越洋', '樓記', '是說', '新語', '卡車', '球球',
             '老蚯', '學海', '無涯', '認領', '認領']
  def hash_decoy_text(date)
    p = date.jd
    p = p * 19920401 % 45
    ApplicationHelper::OPTIONS[p]
  end

  require 'uri'
  def is_valid_url(url)
    return (url != nil and url =~ /\A#{URI::regexp}\z/)
  end
end
