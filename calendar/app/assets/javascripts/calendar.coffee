# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

make_date_string = (d) ->
  return d

class CalendarJS
  @init: ->
    console.log('here!')
    $('button').click( ->
      d = $(this).data('date')
      $('#targetDateInput').val(d)
      $('#targetDateShow').text(make_date_string(d))
      $('#deleteButton').hide()
      $('#entryId').val('')
      $('.modal').modal({
        blurring: true,
        onApprove: ->
          $('#new_entry').submit()
          return false
      }).modal('show')
    )
    c = $('.calendar-day:not([data-entry="entry-none"])')
    c.addClass('calendar-day-with-entry')
    c.click( ->
      $('.watching').removeClass('watching')
      entryId = $(this).data('entry')
      $(this).addClass('watching')
      $('#' + entryId).addClass('watching')
      window.location.hash = entryId
    )
    c = $('.edit-entry-icon')
    c.click( ->
      entry = $(this).parents('.entry')
      eid = entry.attr('id')
      edate = entry.data('date')
      emsg = entry.find('.entry-message').data('msg')
      eurl = entry.find('.entry-message').data('url')
      
      $('#entryId').val(eid.substring(6))
      $('#targetDateInput').val(edate)
      $('#targetDateShow').text(make_date_string(edate))
      $('#deleteButton').attr('href', "/entry/#{eid.substring(6)}/destroy")
      $('#deleteButton').show()
      $('#messageInput').val(emsg)
      $('#urlInput').val(eurl)
      $('.modal').modal({
        blurring: true,
        onApprove: ->
          $('#new_entry').submit()
          return false
      }).modal('show')
    )
    console.log('haha', new Date())

window.CalendarJS = CalendarJS

