class Score < ActiveRecord::Base
  belongs_to :score_board
  belongs_to :match, touch: true

  after_update :update_match_stats
  after_create :update_match_stats

  before_create :set_winner
  before_update :set_winner

#  validates :match, uniqueness: { scope: :match}
  validates :team_1_goals, :numericality => {:greater_than_or_equal_to => 0}
  validates :team_2_goals, :numericality => {:greater_than_or_equal_to => 0}
#  validates :winner_team_id, presence: true

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
    end
  end

  def update_match_stats
    unless self.match.match_type != Match::GROUP_USERS || self.match.match_type != Match::GROUP_MAIN
      binding.pry
      self.match.update_teams_stats
      leaders = self.match.team_1.group.group.group_leaders_for_score_board(self.score_board)
      bottom = self.match.team_1.group.group.group_bottom_for_score_board(self.score_board)
      set_group_positions(leaders,bottom)
    end

  end

  def set_group_positions(leaders,bottom)
    team_s_1 = leaders.first.team_stats.for_scoreboard(self.score_board)
    team_s_1.set_position(1)
    team_s_2 = leaders.second.team_stats.for_scoreboard(self.score_board)
    team_s_2.set_position(2)
    team_s_1.save
    team_s_2.save
    team_s_3 = bottom.first.team_stats.for_scoreboard(self.score_board)
    team_s_4 = bottom.first.team_stats.for_scoreboard(self.score_board)
    team_s_3.set_position(3)
    team_s_3.save
    team_s_4.set_position(4)
    team_s_4.save
  end


end
