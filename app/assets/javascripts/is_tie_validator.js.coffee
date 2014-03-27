$.validator.addMethod "isTie", ((value, element, param) ->
  isValid = true
  console.log param
  console.log value
  console.log element
  if value == param
    isValid = false
  isValid
), "No pueden haber empates en esta etapa"  