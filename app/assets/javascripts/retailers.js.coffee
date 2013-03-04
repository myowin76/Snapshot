
jQuery ->
	$('#retailers').dataTable
		"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
		"sPaginationType": 'full_numbers',
		"bStateSave": true,
		"aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]