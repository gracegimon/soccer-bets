class Team < ActiveRecord::Base
  has_many :matches
  has_many :team_stats
  has_many :players
  
  belongs_to :group
  validates :name, uniqueness: true

  def read_team_stats(score_board)
    team_stats = self.team_stats.where(score_board_id: score_board.id).first
    team_stats.set_current_stats
  end

  def group
  	GroupTeam.find_by_team_id(self.id)
  end

end
