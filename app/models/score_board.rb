class ScoreBoard < ActiveRecord::Base
  has_many :scores
  has_many :matches
  belongs_to :user
  belongs_to :tournament
  before_create :valid_name
  after_create :generate_matches

  # TYPE 0 --> SCOREBOARD WORTH 50$
  # TYPE 1 --> SCOREBOARD WORTH 100$
  # IS_ACTIVE set to TRUE only when user has paid.

  # This method should see all of the scoreboards that
  # the user has and check if this name is unique 
  # for him
  def valid_name
    unless user.nil?
      if user.score_boards.find_by_name(name).nil?
        true
      else
        errors[:name] <<  " is already being used"
        false
      end
    end
  end

  # This method generate group matches for each scoreboard
  # taken from the standard matches
  def generate_matches
    unless self.user.nil? || self.user.is_admin?
      main_matches = Match.where(match_type: 0)
      main_matches.each do |match|
        new_match = Match.new(team_1_id: m.team_1_id, team_2_id: m.team_2_id, city: m.city, stadium_id: m.stadium_id, match_type: 1 , date: m.date)
        new_match.score_board_id = self.id
        new_match.save
      end
    end
  end


end
