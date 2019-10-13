require 'pp'

class PersonalBestsController < ApplicationController

  def change
    if @signed_in_user
      if User.find(@signed_in_user[:id]).personal_bests
        User.find(@signed_in_user[:id]).personal_bests.update_attribute(params[:puzzle_name].to_sym, params[:personal_best]) 
      else
        @personal_bests = @signed_in_user.personal_bests.create
        User.find(@signed_in_user[:id]).personal_bests.update_attribute(params[:puzzle_name].to_sym, params[:personal_best]) 
      end
    end
  end

  def personal_bests_params
    params.permit(:puzzle_name, :personal_best)
  end
end
