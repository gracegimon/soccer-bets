console.log("CREATE")
console.log('#<%= escape_javascript @score.match.team_1_id.to_s%>J')

<%# Played games %>
$("#<%= escape_javascript @score.match.team_1_id.to_s%>J").html("<%= escape_javascript @score.match.team_1.team_stats.for_scoreboard(@score.score_board).played_games.to_s %>")
$("#<%= escape_javascript @score.match.team_2_id.to_s%>J").html("<%= escape_javascript @score.match.team_2.team_stats.for_scoreboard(@score.score_board).played_games.to_s %>")

<%# Won games %>
$("#<%= escape_javascript @score.match.team_1_id.to_s%>G").html("<%= escape_javascript @score.match.team_1.team_stats.for_scoreboard(@score.score_board).won_games.to_s %>")
$("#<%= escape_javascript @score.match.team_2_id.to_s%>G").html("<%= escape_javascript @score.match.team_2.team_stats.for_scoreboard(@score.score_board).won_games.to_s %>")

<%# Tied games %>
$("#<%= escape_javascript @score.match.team_1_id.to_s%>E").html("<%= escape_javascript @score.match.team_1.team_stats.for_scoreboard(@score.score_board).tied_games.to_s %>")
$("#<%= escape_javascript @score.match.team_2_id.to_s%>E").html("<%= escape_javascript @score.match.team_2.team_stats.for_scoreboard(@score.score_board).tied_games.to_s %>")

<%# Lost games %> 
$("#<%= escape_javascript @score.match.team_1_id.to_s%>P").html("<%= escape_javascript @score.match.team_1.team_stats.for_scoreboard(@score.score_board).lost_games.to_s %>")
$("#<%= escape_javascript @score.match.team_2_id.to_s%>P").html("<%= escape_javascript @score.match.team_2.team_stats.for_scoreboard(@score.score_board).lost_games.to_s %>")

<%# Goals favor %> 
$("#<%= escape_javascript @score.match.team_1_id.to_s%>GF").html("<%= escape_javascript @score.match.team_1.team_stats.for_scoreboard(@score.score_board).goals_favor.to_s %>")
$("#<%= escape_javascript @score.match.team_2_id.to_s%>GF").html("<%= escape_javascript @score.match.team_2.team_stats.for_scoreboard(@score.score_board).goals_favor.to_s %>")

<%# Goals Aggainst %>
$("#<%= escape_javascript @score.match.team_1_id.to_s%>GC").html("<%= escape_javascript @score.match.team_1.team_stats.for_scoreboard(@score.score_board).goals_aggainst.to_s %>")
$("#<%= escape_javascript @score.match.team_2_id.to_s%>GC").html("<%= escape_javascript @score.match.team_2.team_stats.for_scoreboard(@score.score_board).goals_aggainst.to_s %>")

<%# Diff Goals %>
$("#<%= escape_javascript @score.match.team_1_id.to_s%>DIF").html("<%= escape_javascript (@score.match.team_1.team_stats.for_scoreboard(@score.score_board).goals_favor - @score.match.team_1.team_stats.for_scoreboard(@score.score_board).goals_aggainst).to_s %>")
$("#<%= escape_javascript @score.match.team_2_id.to_s%>DIF").html("<%= escape_javascript (@score.match.team_2.team_stats.for_scoreboard(@score.score_board).goals_favor - @score.match.team_2.team_stats.for_scoreboard(@score.score_board).goals_aggainst).to_s %>")


<%# Points %>
$("#<%= escape_javascript @score.match.team_1_id.to_s%>PTS").html("<%= escape_javascript @score.match.team_1.team_stats.for_scoreboard(@score.score_board).points.to_s %>")
$("#<%= escape_javascript @score.match.team_2_id.to_s%>PTS").html("<%= escape_javascript @score.match.team_2.team_stats.for_scoreboard(@score.score_board).points.to_s %>")

<%# Leadership %>
$("#<%= escape_javascript @score.match.team_1_id.to_s%>LD").html("<%= escape_javascript @score.match.team_1.team_stats.for_scoreboard(@score.score_board).final_position %>")
$("#<%= escape_javascript @score.match.team_2_id.to_s%>LD").html("<%= escape_javascript @score.match.team_2.team_stats.for_scoreboard(@score.score_board).final_position %>")

if @positions_equal
	console.log "Equal"
	$(".positions-equal").html("<p> Por favor recargar página de haber empate en posiciones </p>")