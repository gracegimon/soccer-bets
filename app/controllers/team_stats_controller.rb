class TeamStatsController < ApplicationController

  def change_position
    @ts = TeamStat.find(params[:id])
    position = @ts.position
    order_number = params[:order_number].to_i
    if order_number > 0
      @ts.set_position(position + 1)
    else
      @ts.set_position(position)
    end
    @ts.save
    binding.pry
  end
end
