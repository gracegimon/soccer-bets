$(".message-position").html("<label class='success'> <%= t('notices.successful_save') %> </label>")
$("tr#<%=@score_board.id%>").empty()
$("#active > tbody").append('<%= j render "score_boards/row", score_board: @score_board %>')