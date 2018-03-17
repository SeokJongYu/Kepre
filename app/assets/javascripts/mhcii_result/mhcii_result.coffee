# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  return unless page.controller() == 'mhcii_result' && page.action() == 'plot'
  jQuery ->
    Morris.Line
      element: 'MHCII_chart'
      data: $('#MHCII_chart').data('results')
      xkey: 'consensus_percentile_rank'
      ykeys: ['consensus_percentile_rank','smm_align_rank','nn_align_rank', 'sturniolo_rank']
      labels: ['consensus_percentile_rank','smm_align_rank','nn_align_rank', 'sturniolo_rank']
      parseTime: false
      xLabelMargin: 10
      hoverCallback: (index, options) ->
        row = options.data[index]
        row.peptide
    