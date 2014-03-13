class ScoreBoardsController < ApplicationController
  before_filter :authenticate
  before_action :check_admin, only: [:tournament_score_board, :show_for_admin]
  before_action :check_published, only: [:show]

  def index
    @score_boards = current_user.score_boards
    @user = current_user
  end
  
  def show
    @score_board = ScoreBoard.find(params[:id])
    @user = @score_board.user
    @groups = current_tournament.groups
  end

  def show_for_admin
    @score_boards_not_active = ScoreBoard.where(is_active: false, is_published: true, tournament_id: current_tournament.id)
    @score_boards_active = ScoreBoard.where(is_active: true, is_published: true, tournament_id: current_tournament.id)
  end

  def tournament_score_board
    @tournament = Tournament.find(params[:id])
    @groups = @tournament.groups
    @score_board = main_score_board
  end

  def ranking
    @score_boards = ScoreBoard.not_main_board.active.order(points: :desc)
  end

  def create
    @user = User.find(params[:user_id])
    @score_board = @user.score_boards.create(params[:score_board].permit(:name,:board_type,:is_active, :tournament_id))
    if @score_board.errors.empty?
      redirect_to user_score_board_path(@user,@score_board)
    else
      flash[:error] = @score_board.errors
      redirect_to @user
    end
  end

  def show_round_of_16
    @score_board = ScoreBoard.find(params[:id])
    match_type = Match::R16
    @is_main = @score_board.is_main?
    if @is_main
      match_type = Match::R16_MAIN
    end
    @matches = Match.where(match_type: match_type, score_board_id: @score_board.id).order(:match_number)
    if @matches.empty?
      @matches = @score_board.calculate_round_of_16
    else
      @matches = @score_board.update_round_of_16(@matches)
    end
  end

  def show_quarter_finals
    @score_board = ScoreBoard.find(params[:id])
    match_type_r16 = Match::R16
    match_type_quarters = Match::QUARTER
    @is_main = @score_board.is_main?
    if @is_main
      match_type_r16 = Match::R16_MAIN
      match_type_quarters = Match::QUARTER_MAIN
    end    
    @matches_r16 = Match.where(match_type: match_type_r16, score_board_id: @score_board.id).order(:match_number)
    @matches = Match.where(match_type: match_type_quarters, score_board_id: @score_board.id).order(:match_number)
    if @score_board.matches_have_score(@matches_r16)

      if @matches.empty? || @matches.count < 4
        @matches = @score_board.calculate_quarters
      else
        @matches = @score_board.update_quarters(@matches)
      end
    else
      flash[:error] = "Por favor, guarda todos los resultados"
      redirect_to action: 'show_round_of_16'
    end
  end

  def show_semi_finals
    @score_board = ScoreBoard.find(params[:id])
    match_type_quarters = Match::QUARTER
    match_type_semi = Match::SEMI
    @is_main = @score_board.is_main?
    if @is_main
      match_type_semi = Match::SEMI_MAIN
      match_type_quarters = Match::QUARTER_MAIN
    end      
    @matches_quarters = Match.where(match_type: match_type_quarters, score_board_id: @score_board.id).order(:match_number)
    @matches = Match.where(match_type: match_type_semi, score_board_id: @score_board.id).order(:match_number)
    if @score_board.matches_have_score(@matches_quarters)
      if @matches.empty? || @matches.count < 2
        @matches = @score_board.calculate_semi_finals
      else
        @matches = @score_board.update_semi_finals(@matches)
      end
    else
      flash[:error] = "Por favor, guarda todos los resultados"
      redirect_to action: 'show_quarter_finals'
    end
  end

  def show_finals
    @score_board = ScoreBoard.find(params[:id])
    match_type_third = Match::THIRD
    match_type_semi = Match::SEMI
    match_type_final = Match::FINAL
    @is_main = @score_board.is_main?
    if @is_main
      match_type_third = Match::THIRD_MAIN
      match_type_semi = Match::SEMI_MAIN
      match_type_final = Match::FINAL_MAIN
    end     
    @matches_semi = Match.where(match_type: match_type_semi, score_board_id: @score_board.id).order(:match_number)
    @final = Match.where(match_type: match_type_final, score_board_id: @score_board.id).first
    @third = Match.where(match_type: match_type_third, score_board_id: @score_board.id).first
    @matches = []
    if @score_board.matches_have_score(@matches_semi)
      if @final.nil?
        @final = @score_board.calculate_final
      else
        @final = @score_board.update_final
      end
      if @third.nil?
        @third = @score_board.calculate_third_place
      else
        @third = @score_board.update_third_place
      end
      @matches = [@final, @third]
    else
      flash[:error] = "Por favor, guarda todos los resultados"
      redirect_to action: 'show_semi_finals'      
    end

  end

  def update
    @score_board = ScoreBoard.find(params[:id])
    if @score_board.update_attributes(score_board_params)
      flash[:notice] = "Publicado"
      redirect_to action: 'wait'
    end

    respond_to do |format|
      format.js
      format.html
    end

  end

  def wait
    @score_board = ScoreBoard.find(params[:id])
  end

  def finish_phase
    type = params[:phase]
    ScoreBoard.update_points_for_score_boards(type, current_tournament)
  end


  private


  def score_board_params
    params.require(:score_board).permit(:name,:board_type,:is_active, :tournament_id, :is_published)
  end

  def check_published
    is_published = ScoreBoard.find(params[:id]).is_published?
    if is_published
      flash[:notice] = "Esta quiniela ya fue completada"
      redirect_to user_path(params[:user_id])
    end
  end

end
