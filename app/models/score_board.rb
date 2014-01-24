class ScoreBoard < ActiveRecord::Base
  has_many :scores
  belongs_to :user
  belongs_to :tournament

 # TYPE 0 --> SCOREBOARD WORTH 50$
 # TYPE 1 --> SCOREBOARD WORTH 100$
 # IS_ACTIVE set to TRUE only when user has paid.

 
end
