class TeamStatsController < ApplicationController

  def change_position
    @ts = TeamStat.find(params[:id])
    position = @ts.position
    value = params[:value].to_i
    @ts.set_position(value)
    @ts.save

  end
end
