class TeamStat < ActiveRecord::Base
  belongs_to :team
  belongs_to :score_board

  DISCARDED = 0
  IN_GROUP = 1
  ROUND_16 = 2
  QUARTERS = 3
  SEMI_FINALS = 4
  THIRD_PLACE_OFF = 5
  FINALS = 6

  def update_team_stats(score)
  	if score.winner_team_id == self.team.id 
  		self.won_games += 1
  	elsif score.winner_team_id == 0
  		self.tied_games += 1
  	else
  		self.lost_games += 1
  	end
  	self.played_games += 1
  end

end
 