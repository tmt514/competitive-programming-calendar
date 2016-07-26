class UserprofilesController < ApplicationController

  POSSIBLE_UPDATE_FIELDS = ["Handle:CF", "Handle:Topcoder", "Handle:UVa"]
  POSSIBLE_UPDATE_RULES = {
    "Handle:CF": /^[0-9A-Za-z_]*$/,
    "Handle:Topcoder": /^[0-9A-Za-z]*$/,
    "Handle:UVa": /^[0-9A-Za-z]*$/
  }

  def ajax_update
    if session[:user_id] == nil
      return redirect_to root_url
    end

    profile = get_profile
    if !POSSIBLE_UPDATE_FIELDS.include?(profile[:name])
      flash[:danger] = "Failed to update due to illegal names."
      return redirect_to profile_path 
    end

    if (POSSIBLE_UPDATE_RULES[profile[:name].intern] =~ profile[:value]) == nil
      flash[:danger] = "Failed to update due to illegal value."
      return redirect_to profile_path
    end
    
    user = User.find(session[:user_id])
    userprofile = user.userprofiles.where(name: profile[:name]).first || Userprofile.new(user: user)
    puts userprofile.inspect
    userprofile.update!(profile)


    if profile[:name] == "Handle:CF"
      CodeforcesGetRatingJob.perform_later(user)
    end
    
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
