console.log "QUARTERS"

jQuery("#tabs-3").html("<%= j render 'score_boards/show_quarter_finals', {:matches=> @matches} %>");
