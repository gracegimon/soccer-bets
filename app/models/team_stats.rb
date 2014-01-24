class TeamStats < ActiveRecord::Base
  belongs_to :team

  DISCARDED = 0
  IN_GROUP = 1
  ROUND_16 = 2
  QUARTERS = 3
  SEMI_FINALS = 4
  THIRD_PLACE_OFF = 5
  FINALS = 6


end
 