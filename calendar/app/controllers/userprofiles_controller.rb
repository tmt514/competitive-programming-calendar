class UserprofilesController < ApplicationController

  POSSIBLE_UPDATE_FIELDS = ["Handle:CF", "Handle:Topcoder", "Handle:UVa"]

  def ajax_update
    if session[:user_id] == nil
      return redirect_to root_url
    end

    profile = get_profile
    if !POSSIBLE_UPDATE_FIELDS.include?(profile[:name])
      flash[:danger] = "Failed to update due to illegal names."
      return redirect_to profile_path 
    end
    
    user = User.find(session[:user_id])
    userprofile = user.userprofiles.where(name: profile[:name]).first || Userprofile.new
    puts userprofile.inspect
    userprofile.user = user
    userprofile.update!(profile)
    
    return render json: userprofile
  end


  def show
    if session[:user_id] == nil
      return redirect_to root_url
    end

    user = User.find(session[:user_id])
    userprofile = user.userprofiles.all
    @profile = {}
    userprofile.each do |p|
      @profile[p.name] = p.value
    end
    puts ">>>>>>>" + @profile.inspect
  end


  def get_profile
    params.fetch(:profile, {}).permit(:name, :value)
  end
end
