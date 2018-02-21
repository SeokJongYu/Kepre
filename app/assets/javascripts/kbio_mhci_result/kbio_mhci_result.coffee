# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
    return unless page.controller() == 'kbio_mhci_result' && page.action() == 'plot'

    about_string = 'Zoom, scroll, and click buttons to interact with the clustergram. <a href="http://amp.pharm.mssm.edu/clustergrammer/help"> <i class="fa fa-question-circle" aria-hidden="true"></i> </a>'
    args = 
        root: '#KBIO_MHCI_chart'
        'network_data': $('#KBIO_MHCI_chart').data('results')
        'about': about_string
        'col_tip_callback': test_col_callback
        'tile_tip_callback': test_tile_callback
        'dendro_callback': dendro_callback
        'matrix_update_callback': matrix_update_callback
        'cat_update_callback': cat_update_callback
        'tile_colors': ['#FF0000','##FFFF00']
        'sidebar_width': 150

    matrix_update_callback = ->
        if genes_were_found[@root]
            enr_obj[@root].clear_enrichr_results false
        return

    cat_update_callback = ->
        console.log 'callback to run after cats are updated'
        return

    test_tile_callback = (tile_data) ->
        row_name = tile_data.row_name
        col_name = tile_data.col_name
        return

    test_col_callback = (col_data) ->
        col_name = col_data.name
        return

    dendro_callback = (inst_selection) ->
        inst_rc = undefined
        inst_data = inst_selection.__data__
        # toggle enrichr export section
        if inst_data.inst_rc == 'row'
            d3.select('.enrichr_export_section').style 'display', 'block'
        else
            d3.select('.enrichr_export_section').style 'display', 'none'
        return

    resize_container = (args) ->
        #screen_width = window.innerWidth
        #screen_height = window.innerHeight - 20
        screen_width = document.getElementById('KBIO_MHCI_chart').offsetWidth
        screen_height = document.getElementById('KBIO_MHCI_chart').offsetHeight
        d3.select(args.root).style('width', screen_width + 'px').style 'height', screen_height + 'px'
        return

    resize_container args

    d3.select(window).on 'resize', ->
        resize_container args
        cgm.resize_viz()
        return

    cgm = Clustergrammer(args)
    check_setup_enrichr cgm
    d3.select(cgm.params.root + ' .wait_message').remove()
