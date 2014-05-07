$.validator.addMethod "isTie", ((value, element, param) ->
  isValid = true
  if value == $(element).parent().siblings().find("[name='score[team_"+param+"_goals]']").val() 
    isValid = false
  isValid
), "No se permiten empates en esta etapa"  