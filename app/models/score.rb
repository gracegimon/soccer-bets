class Score < ActiveRecord::Base
  belongs_to :score_board
  belongs_to :match, touch: true

  before_update :set_winner
  before_create :set_winner

#  validates :match, uniqueness: { scope: :match}

  def match
  	Match.find(self.match_id)
  end

  def score_board
  	ScoreBoard.find(self.scoreboard_id)
  end

  def set_winner
  	if team_1_goals > team_2_goals
  		self.winner_team_id = self.match.team_1_id
  	elsif team_2_goals > team_1_goals
  		self.winner_team_id = self.match.team_2_id
  	else
  		self.winner_team_id = 0 # This means tie
  	end

    self.match.update_teams_stats
  end

end
