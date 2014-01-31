class Score < ActiveRecord::Base
  belongs_to :score_board
  belongs_to :match

  validates :match, uniqueness: { scope: :match}

  def match
  	Match.find(self.match_id)
  end

  def score_board
  	ScoreBoard.find(self.score_board)
  end
end
