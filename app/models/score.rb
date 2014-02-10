class Score < ActiveRecord::Base
  belongs_to :score_board
  belongs_to :match

  after_create :set_winner
#  validates :match, uniqueness: { scope: :match}

  def match
  	Match.find(self.match_id)
  end

  def score_board
  	ScoreBoard.find(self.score_board)
  end

  def set_winner
  	if team_1_goals > team_2_goals
  		winner_team_id = team_1_id
  	elsif team_2_goals > team_1_goals
  		winner_team_id = team_2_goals
  	else
  		winner_team_id = 0 # This means tie
  	end
  	self.match.update_teams_stats
  end

end
