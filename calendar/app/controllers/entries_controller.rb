class EntriesController < ApplicationController
  def index
  end

  def new
  end

  def create
    data = get_entry
    if session[:user_id] == nil or data[:target] == nil
      return redirect_to root_url
    end
    target = Date.parse(data[:target])
    id = params[:entry_id].to_i
    entry = Entry.where(id: id).first || Entry.new()

    if entry.user_id != nil and entry.user_id != session[:user_id]
      puts "Somebody wants to cheat!"
      return redirect_to calendar_url(year: target.year, month: target.month)
    end

    if target < Date.today() - 3 or target > Date.today() + 1.year
      puts "Out of Date"
      return redirect_to root_url
    end

    if entry.target != nil and entry.target.to_date != target
      puts "Somebody wants to change date!"
      return redirect_to calendar_url(year: entry.target.year, month: entry.target.month)
    end

    entry.user_id ||= session[:user_id]
    entry.update!(data)
    redirect_to calendar_url(year: target.year, month: target.month)
  end

  def edit
  end

  def update
  end

  def destroy
    id = params.fetch(:id)
    if session[:user_id] == nil
      return redirect_to root_url
    end

    entry = Entry.find(id)
    if session[:user_id] != entry.user_id
      puts "Somebody wants to cheat!"
      return redirect_to root_url
    end

    target = entry.target.to_date
    Entry.destroy(id)
    redirect_to calendar_url(year: target.year, month: target.month)
  end

  def get_entry
    params.fetch(:entry, {}).permit(:target, :message, :url, :status)
  end
end
