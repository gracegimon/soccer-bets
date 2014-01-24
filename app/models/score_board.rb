class ScoreBoard < ActiveRecord::Base
  has_many :scores
  belongs_to :user
  belongs_to :tournament

 # TYPE 0 --> SCOREBOARD WORTH 50$
 # TYPE 1 --> SCOREBOARD WORTH 100$
 # IS_ACTIVE set to TRUE only when user has paid.


  def valid_name
  # This method should see all of the scoreboards that
  # the user has and check if this name is unique 
  # for him
  end
end
