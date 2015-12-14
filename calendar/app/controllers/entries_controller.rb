class EntriesController < ApplicationController
  def index
  end

  def new
  end

  def create
    if session[:user_id] == nil
      redirect_to root_url
    end
    id = params[:entry_id].to_i
    entry = Entry.where(id: id).first || Entry.new()

    if entry.user_id != nil and entry.user_id != session[:user_id]
      puts "Somebody wants to cheat!"
      redirect_to root_url
    end

    entry.user_id ||= session[:user_id]
    entry.update!(get_entry)
    redirect_to root_url
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def get_entry
    params.fetch(:entry, {}).permit(:target, :message, :url)
  end
end
