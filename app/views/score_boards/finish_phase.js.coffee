
$(".loader-position-phase").empty();
$(".message-position").empty();

<% if @has_error %>
	$(".loader-position-phase").html("<label class='error'> No se puede terminar la etapa si hay partidos sin resultados</label>")
<% else %>
	$(".loader-position-phase").html("<label class='success'> Se actualizaron todos los puntos de las quinielas existentes </label>")
	$(".js-finish-phase > btn").addClass("disabled")