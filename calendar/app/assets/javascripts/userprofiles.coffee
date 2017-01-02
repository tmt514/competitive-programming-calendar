# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


toUpdate = (url, data, callback, ret) ->
  $.post(url, data, callback.bind(null, ret))


isValidCodeforcesAccount = (name, handle, success) ->
  $("span[data-warning-for='#{name}']").html("<font color='red'>正在向 Codeforces 確認，如果毫無反應請重新整理與輸入...</font>")
  win = ((name, success, ret) ->
    console.log(ret)
    if ret.status == "OK"
      $("span[data-warning-for='#{name}']").html("<font color='blue'>確認帳號存在，更新資料中！</font>")
      success(ret)
  ).bind(null, name, success)
  $.get('http://codeforces.com/api/user.info', { 'handles': handle }, win)


class UserProfileJS
  @perform_initialization: ->
    $("form.profile-update").each((idx, form) ->
      btn = $(form).find('button')
      $('input.profile-input').keypress(((btn) ->
        if window.event && window.event.keyCode == 13
          $(btn).click()
          return false
        return true
        ).bind(this, btn)
      )
      handler_function = ((form, btn, e) ->
        e.preventDefault()
        btn.addClass('loading')
        btn.attr('disabled', true)

        name = $(form).find("input[name='profile[name]']").val()
        value = $(form).find("input[name='profile[value]']").val()
        data = {
          "profile[name]": $(form).find("input[name='profile[name]']").val()
          "profile[value]": $(form).find("input[name='profile[value]']").val()
        }

        url = $(form).data('action')


        success = ((btn, name, value, ret, data) ->
          rank = ret.result[0].rank
          $("span[data-value-for='#{name}']").html(value)
          $("span[data-value-for='#{name}']").removeClass()
          $("span[data-value-for='#{name}']").addClass("cf #{rank}")
          $(btn).removeClass('loading')
          $(btn).attr('disabled', false)
          $("span[data-warning-for='#{name}']").html("<font color='green'>更新成功！</font>")
            .fadeOut(500, ->
              $(this).html("").fadeIn(500)
            )
        ).bind(null, btn, name, value)

        if name == 'Handle:CF'
          isValidCodeforcesAccount(name, value, toUpdate.bind(null, url, data, success))
        else
          toUpdate(url, data, success)

        console.log(data)
        
        return false
      ).bind(this, form, btn)
      $(btn).click(handler_function)
    )


window.UserProfileJS = UserProfileJS
