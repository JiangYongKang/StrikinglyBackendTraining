# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  # 鼠标滑入事件
  $('tr').mouseover( -> 
    $(@).removeClass('out')
    $(@).addClass('over')
  )
  
  # 鼠标滑出事件
  $('tr').mouseout( ->
    $(@).removeClass('over')
    $(@).addClass('out')
  )
