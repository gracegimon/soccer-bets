class TeamStatsController < ApplicationController

  def change_position
    @ts = TeamStat.find(params[:id])
    position = @ts.position
    value = params[:value].to_i
    @ts.set_position(value)
    @ts.save

    # update round of 16
    @score_board = @ts.score_board
    match_type = Match::R16
    @is_main = @score_board.is_main?
    if @is_main
      match_type = Match::R16_MAIN
    end
    # up
    @matches = Match.where(match_type: match_type, score_board_id: @score_board.id).order(:match_number)
    if @matches.empty?
      @matches = @score_board.calculate_round_of_16
    else
      @matches = @score_board.update_round_of_16(@matches)
    end
  end

  def update_team_stats_for_group
    @group = Group.find(params[:group_id])
    @score_board = ScoreBoard.find(params[:score_board_id])
    @teams = @group.teams
    @teams.each do |team|
      team.read_team_stats(@score_board)
    end
    all = @group.group_order_for_score_board(@score_board)
    leaders = [all[0], all[1]]
    bottom = [all[2], all[3]]
    Score.set_group_positions(leaders,bottom,@score_board)
  end
end