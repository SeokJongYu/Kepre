# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  return unless page.controller() == 'data' && page.action() == 'show'
  jQuery ->
    Morris.Donut
      element: 'seq_chart'
      data: $('#seq_chart').data('results')
