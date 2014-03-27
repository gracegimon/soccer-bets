$.validator.addMethod "isTie", ((value, element, param) ->
  isValid = true
  if value == param
    isValid = false
  isValid
), "No pueden haber empates en esta etapa"  