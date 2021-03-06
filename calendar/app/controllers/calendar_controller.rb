require 'date'

class CalendarController < ApplicationController
  def index
    today = Date.today()
    redirect_to "/calendar/#{today.year}/#{today.month}"
  end

  def show
    @year = params[:year].to_i
    @month = params[:month].to_i
    
    # check valid year month 
    if @year >= 2018 or @year <= 2014
      return redirect_to root_url
    end

    if @month >= 13 or @month <= 0
      raise ActionController::RoutingError.new('Not Found')
    end

    # list of all entries
    @entries = []
    # make a calendar
    @today = Date.today()
    @weeks = []
    @total_count = 0
    now = Date.new(@year, @month, 1)
    now -= now.cwday % 7
    for w in 0..5
      week = []
      for i in 0..6
        entry = Entry.blogs.where("target >= :today AND target < :tomorrow", {today: now, tomorrow: now+1}).first
        entry = nil if now.month != @month
        @total_count += 1 if now.month == @month
        @entries << entry if entry != nil
        week << { date: now, entry: entry, open: (now >= @today and now.month == @month) }
        now += 1
      end
      if week.last[:date].month == @month or week.first[:date].month == @month
        @weeks << week
      end
    end

    # get prev and next month url
    @prev_month = Date.new(@year, @month, 1) - 1.month
    @next_month = Date.new(@year, @month, 1) + 1.month
    @new_entry = Entry.new()
    render :index
  end
end
