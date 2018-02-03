# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  Morris.Line
    element: 'MHCI_chart'
    data: $('#MHCI_chart').data('results')
    xkey: 'id'
    ykeys: ['percentile_rank','ann_rank','smm_rank']
    labels: ['percentile_rank','ann_rank','smm_rank']
    parseTime: false
    xLabelMargin: 10