$.validator.addMethod "isTie", ((value, element, param) ->
  isValid = true
  if value == $(element).parent().siblings().find("[name='score[team_"+param+"_goals]']").val() 
    isValid = false
  isValid
), "No ties allowed in this phase"  