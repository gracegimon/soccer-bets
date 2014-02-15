class Score < ActiveRecord::Base
  belongs_to :score_board
  belongs_to :match, touch: true

  before_update :set_winner
  before_create :set_winner

#  validates :match, uniqueness: { scope: :match}
  validates :team_1_goals, :numericality => {:greater_than_or_equal_to => 0}
  validates :team_2_goals, :numericality => {:greater_than_or_equal_to => 0}

  def match
  	Match.find(self.match_id)
  end

  def score_board
  	ScoreBoard.find(self.scoreboard_id)
  end

  def set_winner
    unless team_1_goals.nil? || team_2_goals.nil?
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

end
