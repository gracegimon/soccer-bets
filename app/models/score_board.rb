class ScoreBoard < ActiveRecord::Base
  has_many :scores
  has_many :matches
  belongs_to :user
  belongs_to :tournament
  before_create :valid_name
  after_create :generate_matches, :create_team_stats

  scope :not_main_board, -> {where "user_id IS NOT NULL"}
  scope :active, -> {where is_active: true}
  scope :published, -> {where is_published: true}

  validates_presence_of :name, :tournament_id

  # TYPE 0 --> SCOREBOARD WORTH 50$
  # TYPE 1 --> SCOREBOARD WORTH 200$
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
    #Self points
    self.points = 0
    unless self.user.nil? || self.user.is_admin?
      main_matches = Match.where(match_type: Match::GROUP_MAIN)
      main_matches.each do |match|
        new_match = Match.new(team_1_id: match.team_1_id, team_2_id: match.team_2_id, city: match.city, stadium_id: match.stadium_id, match_type: Match::GROUP_USERS , date: match.date, match_number: match.match_number)
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
                    goals_favor: 0, goals_aggainst: 0, score_board_id: self.id, lost_games: 0, position: 0)
        team_stat.save
      end
    end
  end

  # Returns matches for Round of 16
  # phase, for normal users and admin
  def round_of_16
    groups = self.tournament.groups
    leaders = []
    groups.each do |group|
      leaders << group.group_leaders_for_score_board(self)
    end
    team_1A = leaders.first.first
    team_2A = leaders.first.second
    team_1B = leaders[1][0]
    team_2B = leaders[1][1]
    team_1C = leaders[2][0]
    team_2C = leaders[2][1]
    team_1D = leaders[3][0]
    team_2D = leaders[3][1]
    team_1E = leaders[4][0]
    team_2E = leaders[4][1]
    team_1F = leaders[5][0]
    team_2F = leaders[6][0]
    team_1G = leaders[7][0]
    team_2G = leaders[7][1]

    team_1H = leaders[8][0]
    team_2H = leaders[8][1]

    if self.user.is_admin?
      match_type = Match::R16_MAIN
    else
      match_type = Match::R16
    end
    # Match 49
    m1 = Match.new(team_1_id: team_1A, team_2_id: team_2B, city: "Belo Horizonte", stadium_id: nil, match_type: match_type , date: "2014-06-28 11:30:00", match_number: 49)
    m1.save
    # Match 50
    m2 = Match.new(team_1_id: team_1C, team_2_id: team_2D, city: "Rio de Janeiro", stadium_id: nil, match_type: match_type , date: "2014-06-28 15:30:00", match_number: 50)
    m2.save
    # Match 51
    m3 = Match.new(team_1_id: team_1B, team_2_id: team_2A, city: "Fortaleza", stadium_id: nil, match_type: match_type, date: "2014-06-29 11:30:00", match_number: 51)
    m3.save
    # Match 52
    m4 = Match.new(team_1_id: team_1D, team_2_id: team_2C, city: "Recife", stadium_id: nil, match_type: match_type, date: "2014-06-29 15:30:00", match_number: 52)
    m4.save
    # Match 53
    m5 = Match.new(team_1_id: team_1E, team_2_id: team_2F, city: "Brasilia", stadium_id: nil, match_type: match_type , date: "2014-06-30 11:30:00", match_number: 53)
    m5.save
    # Match 54
    m6 = Match.new(team_1_id: team_1G, team_2_id: team_2H, city: "Porto Alegre", stadium_id: nil, match_type: match_type , date: "2014-06-30 15:30:00", match_number: 54)
    m6.save
    # Match 55
    m6 = Match.new(team_1_id: team_1F, team_2_id: team_2E, city: "Sao Paulo", stadium_id: nil, match_type: match_type , date: "2014-07-01 11:30:00", match_number: 55)
    m6.save
    # Match 56
    m7 = Match.new(team_1_id: team_1H, team_2_id: team_2G, city: "Salvador", stadium_id: nil, match_type: match_type , date: "2014-07-01 15:30:00", match_number: 56)
    m7.save
  end

end
