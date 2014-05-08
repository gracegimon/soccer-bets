
$("#<%=@group.id%>").find(".loader-position").html("<p class= 'alert-success-text'> <%= t('notices.saved') %> </p>")
$(".js-save-group").removeClass("disabled")

<% @teams.each do |team| %>
<%# Played games %>
$("#<%= escape_javascript team.id.to_s%>J").html("<%= escape_javascript team.team_stats.for_scoreboard(@score_board).played_games.to_s %>")

<%# Won games %>
$("#<%= escape_javascript team.id.to_s%>G").html("<%= escape_javascript team.team_stats.for_scoreboard(@score_board).won_games.to_s %>")

<%# Tied games %>
$("#<%= escape_javascript team.id.to_s%>E").html("<%= escape_javascript team.team_stats.for_scoreboard(@score_board).tied_games.to_s %>")

<%# Lost games %> 
$("#<%= escape_javascript team.id.to_s%>P").html("<%= escape_javascript team.team_stats.for_scoreboard(@score_board).lost_games.to_s %>")

<%# Goals favor %> 
$("#<%= escape_javascript team.id.to_s%>GF").html("<%= escape_javascript team.team_stats.for_scoreboard(@score_board).goals_favor.to_s %>")

<%# Goals Aggainst %>
$("#<%= escape_javascript team.id.to_s%>GC").html("<%= escape_javascript team.team_stats.for_scoreboard(@score_board).goals_aggainst.to_s %>")

<%# Diff Goals %>
$("#<%= escape_javascript team.id.to_s%>DIF").html("<%= escape_javascript (team.team_stats.for_scoreboard(@score_board).goals_favor - team.team_stats.for_scoreboard(@score_board).goals_aggainst).to_s %>")


<%# Points %>
$("#<%= escape_javascript team.id.to_s%>PTS").html("<%= escape_javascript team.team_stats.for_scoreboard(@score_board).points.to_s %>")

<%# Leadership %>
$("#<%= escape_javascript team.id.to_s%>LD").html("<%= escape_javascript team.team_stats.for_scoreboard(@score_board).final_position %>")

<% end %>