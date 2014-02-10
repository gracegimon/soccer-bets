class ScoreBoard < ActiveRecord::Base
  has_many :scores
  has_many :matches
  belongs_to :user
  belongs_to :tournament
  before_create :valid_name
  after_create :generate_matches, :create_team_stats

  validates_presence_of :name, :tournament_id

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
        new_match = Match.new(team_1_id: match.team_1_id, team_2_id: match.team_2_id, city: match.city, stadium_id: match.stadium_id, match_type: 1 , date: match.date)
        new_match.score_board_id = self.id
        new_match.save
      end
    end
  end

  def create_team_stats
    groups = self.tournament.groups
    groups.each do |group|
      group.teams.each do |t|
        team_stat = TeamStat.new(team_id: t.id, points: 0, status: 1, played_games: 0, won_games:0, tied_games: 0,
                    goals_favor: 0, goals_aggainst: 0, score_board_id: self.id, lost_games: 0)
        team_stat.save
      end
    end
  end


end
