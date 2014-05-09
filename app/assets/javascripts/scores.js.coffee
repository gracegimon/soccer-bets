# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@set_score = (form_class) ->

  $(form_class).keydown (e) ->

    if e.which is 13
      e.preventDefault()

      value = $(this).val()
      console.log value

      if isNaN(value)
        alert "Must be a number between #{min_value} y #{max_value}"
        return

      $.post "/scores/",
        value: value
        student_id: student_id
        is_batch_subject: false

