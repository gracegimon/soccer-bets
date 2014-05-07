
$(".loader-position-phase").empty();
$(".message-position").empty();

if @has_error
	$(".loader-position-phase").html("<label class='error'> <%= t('notices.finish_phase_error') %></label>")
else
	$(".loader-position-phase").html("<label class='success'> <%= t('notices.finish_phase_success') %>  </label>")
	$(".js-finish-phase > btn").addClass("disabled")