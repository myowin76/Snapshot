# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$('#retailers').dataTable
		"aoColumnDefs": [
    	{ 'bSortable': false, 'aTargets': [ -1 ] },
    	{ 'bSortable': false, 'aTargets': [ -2 ] },
    	{ 'bSortable': false, 'aTargets': [ -3 ] },
    	{ 'bSortable': false, 'aTargets': [ -4 ] }
    ]