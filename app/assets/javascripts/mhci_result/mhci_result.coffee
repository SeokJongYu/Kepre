# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  return unless page.controller() == 'mhci_result' && page.action() == 'plot'
  jQuery ->
    Morris.Line
      element: 'MHCI_chart'
      data: $('#MHCI_chart').data('results')
      xkey: 'id'
      ykeys: ['percentile_rank','ann_rank','smm_rank']
      labels: ['percentile_rank','ann_rank','smm_rank']
      parseTime: false
      xLabelMargin: 10
      hoverCallback: (index, options) ->
        row = options.data[index]
        row.peptide
    