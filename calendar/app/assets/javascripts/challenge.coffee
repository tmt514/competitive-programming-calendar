# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready( ->
  $('input.pid-field').change( ->
    box = $(this)
    btn = $(this).parents('form').find('button').first()
    if box.prev().val() == "cf"
      btn.addClass('loading')
      success = ((btn, box, data) ->
        btn.removeClass('loading')
        box.val(data)
      ).bind(null, btn, box.next())
      $.get("/ajax/cf/get_title/#{box.val()}", success)
  )

  $('.create-challenge').submit((e) ->
    e.preventDefault()
    btn = $(this).find('button').first()
    arr = $(this).serializeArray()
    data = {}
    data[x.name] = x.value for x in arr
    console.log(data)
    callback = (ret) ->
      console.log(ret)
    $.post($(this).data('action'), data, callback)
  )

)



# This is the training area
class TrainingArea
  @perform_initialization: ->
    $(document).ready( ->
      $('.currentnum').each( ->
        index = $(this).data('stage')
        @check_currentnum(index)
      )
    )

  @check_currentnum: (stage) ->
    obj = $('.currentnum')
    all = $(".training[data-stage='#{stage}'] .challenge").length
    solved = $(".training[data-stage='#{stage}'] .challenge")
