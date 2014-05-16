class ScoreBoardsController < ApplicationController
  before_filter :authenticate
  before_action :check_admin, only: [:tournament_score_board, :show_for_admin]
  before_action :check_published, only: [:show_after_published]
 # before_action :current_user_is_viewing, except: [:show_after_published]
  before_action :signed_in, only: [:show]

  def index
    @user = User.find(params[:user_id])
    @score_boards = @user.score_boards
    @can_add = false
    if current_user?(@user)
      @can_add = true
    end
  end
  
  def show
    @score_board = ScoreBoard.find(params[:id])
    @user = @score_board.user
    @groups = current_tournament.groups
    if @score_board.is_published?
      redirect_to action: 'show_after_published'
    end
  end

  def show_for_admin
    @score_boards_not_active = ScoreBoard.where(is_active: false, is_published: true, tournament_id: current_tournament.id)
    @score_boards_active = ScoreBoard.not_main_board.where(is_active: true, is_published: true, tournament_id: current_tournament.id)
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
    @score_board = @user.score_boards.create(params[:score_board].permit(:name,:board_type,:is_active, :tournament_id, :points))

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
    match_type_groups = Match::GROUP_USERS
    @is_main = @score_board.is_main?
    if @is_main
      match_type = Match::R16_MAIN
      match_type_groups = Match::GROUP_MAIN
    end
    @matches_group = Match.where(match_type: match_type_groups, score_board_id: @score_board.id)
    @matches = Match.where(match_type: match_type, score_board_id: @score_board.id).order(:match_number)
    if @score_board.matches_have_score(@matches_group)
      if @matches.empty?
        @matches = @score_board.calculate_round_of_16
      else
        @matches = @score_board.update_round_of_16(@matches)
      end
    else
      flash[:error] = "Por favor, guarda todos los resultados de la fase anterior"
      redirect_to action: 'show'
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

  # Publish
  def update
    @score_board = ScoreBoard.find(params[:id])
    match_type_group = Match::GROUP_USERS
    match_type_r16 = Match::R16
    match_type_quarters = Match::QUARTER
    match_type_third = Match::THIRD
    match_type_semi = Match::SEMI
    match_type_final = Match::FINAL    
    @is_main = @score_board.is_main?
    if @is_main
      match_type_group = Match::GROUP_MAIN
      match_type_r16 = Match::R16_MAIN
      match_type_semi = Match::SEMI_MAIN
      match_type_quarters = Match::QUARTER_MAIN
      match_type_third = Match::THIRD_MAIN
      match_type_final = Match::FINAL_MAIN      
    end        
    @matches_group = Match.where(match_type: match_type_group, score_board_id: @score_board.id).order(:match_number)
    @maches_r16 = Match.where(match_type: match_type_r16, score_board_id: @score_board.id).order(:match_number)
    @matches_quarters =  Match.where(match_type: match_type_quarters, score_board_id: @score_board.id).order(:match_number)
    @matches_semi =  Match.where(match_type: match_type_semi, score_board_id: @score_board.id).order(:match_number)
    @match_third =  Match.where(match_type: match_type_third, score_board_id: @score_board.id).order(:match_number)
    @match_final =  Match.where(match_type: match_type_final, score_board_id: @score_board.id).order(:match_number)
    extra_phase = @score_board.extra_phase
    messages = []
    if !@score_board.matches_have_score(@matches_group)
      messages << "Por favor completa los resultados en la etapa de grupos."
    end
    if !@score_board.matches_have_score(@maches_r16)
      messages << "Por favor completa los resultados en la etapa de octavos de final."
    end
    if !@score_board.matches_have_score(@matches_quarters)
      messages << "Por favor completa los resultados en la etapa de cuartos de final."
    end
    if !@score_board.matches_have_score(@matches_semi)
      messages << "Por favor completa los resultados en la etapa de semifinales."
    end
    if !@score_board.matches_have_score(@match_third)
      messages << "Por favor completa los resultados del partido de 3er lugar."
    end
    if !@score_board.matches_have_score(@match_final)
      messages << "Por favor completa los resultados del partido de la final."
    end
    if extra_phase.nil? || !extra_phase.is_complete
      messages << "Por favor complete la etapa 'Extra'"
    end

    if messages.empty?
      if @score_board.update_attributes(score_board_params)
        flash[:notice] = "Publicado"
        if @score_board == main_score_board
          redirect_to action: 'show_after_published', score_board: @score_board
        else
          redirect_to action: 'wait'
        end
      end
    else
      flash[:error] = messages
      redirect_to action: 'show', score_board: @score_board
    end
  end

  def update_active
    @score_board = ScoreBoard.find(params[:id])
    if @score_board.update_attributes(score_board_params)
      if @score_board.is_active
        UserMailer.you_are_active(@score_board.user, @score_board).deliver
      end
    end
  end

  def wait
    @score_board = ScoreBoard.find(params[:id])
    UserMailer.you_should_pay(@score_board.user, @score_board).deliver
  end

  # type -> The next phase
  # type - 2 -> The current phase
  def finish_phase
    type = params[:phase].to_i
    @score_board = main_score_board
    matches = Match.find_by_match_type_score_board(type - 2, @score_board)
    if @score_board.matches_have_score(matches)
      @has_error = false    
      @score_board.update_points_for_score_boards(type, current_tournament)
      tournament = current_tournament
      tournament.current_phase = type
      tournament.save
      respond_to do |format|
        format.html { redirect_to(:action => 'tournament_score_board') }
        format.js
      end    
    else
      @has_error = true
      respond_to do |format|
        format.html { redirect_to(:action => 'tournament_score_board') }
        format.js
      end   
    end
  end

  def show_after_published
    @score_board = ScoreBoard.find(params[:id])
    @status = @score_board.status
    @user = @score_board.user
    @extra = @score_board.extra_phase
    @groups = current_tournament.groups
    @is_main = @score_board.is_main?
    match_type_r16 = Match::R16
    match_type_quarters = Match::QUARTER
    match_type_semi = Match::SEMI
    match_type_third = Match::THIRD
    match_type_final = Match::FINAL
    if @is_main
      match_type_r16 = Match::R16_MAIN
      match_type_quarters = Match::QUARTER_MAIN
      match_type_semi = Match::SEMI_MAIN
      match_type_third = Match::THIRD_MAIN
      match_type_final = Match::FINAL_MAIN
    end
    @matches_r16 = Match.where(match_type: match_type_r16, score_board_id: @score_board.id).order(:match_number)
    @matches_quarters = Match.where(match_type: match_type_quarters, score_board_id: @score_board.id).order(:match_number)
    @matches_semi = Match.where(match_type: match_type_semi, score_board_id: @score_board.id).order(:match_number)
    @final = Match.where(match_type: match_type_final, score_board_id: @score_board.id).first
    @third = Match.where(match_type: match_type_third, score_board_id: @score_board.id).first
  end

  private


  def score_board_params
    params.require(:score_board).permit(:name,:board_type,:is_active, :tournament_id, :is_published)
  end

  def check_published
    is_published = ScoreBoard.find(params[:id]).is_published?
    return true if is_published
  end

  def current_user_is_viewing
    @user = ScoreBoard.find(params[:id]).user
    redirect_to(root_url) unless current_user?(@user)
  end

  def signed_in
    @user = ScoreBoard.find(params[:id]).user unless ScoreBoard.find(params[:id]).nil?
    redirect_to(root_url) unless (current_user?(@user) || !@current_user.nil?)
  end

end
