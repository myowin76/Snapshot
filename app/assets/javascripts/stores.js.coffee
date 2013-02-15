# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$('#tbl-stores').dataTable
  "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
  "sPaginationType": 'full_numbers'
  "aoColumnDefs": [
  	{ 'bSortable': false, 'aTargets': [ -1 ] },
  	{ 'bSortable': false, 'aTargets': [ -2 ] }
  ]

  ###$('#store_retailer_id').chosen()###
  $('#store_retailer_id').chosen({no_results_text: "<a href='/retailers/new' data-remote='true'>Add</a>:"})
  $('#store_country_id').chosen()



  
