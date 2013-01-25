jQuery ->
	$('#tbl-categories').dataTable
		"sDom": '<"top"fli>rt<"bottom"p><"clear">'
		"sPaginationType": 'full_numbers'
		"aoColumnDefs": [
    	{ 'bSortable': false, 'aTargets': [ -1 ] },
    	{ 'bSortable': false, 'aTargets': [ -2 ] }
    ]

  $('#tbl-unpublished').dataTable
    "sDom": '<"top"fli>rt<"bottom"p><"clear">'
		"sPaginationType": 'full_numbers'
		"aoColumnDefs": [
    	{ 'bSortable': false, 'aTargets': [ 0 ] },
    	{ 'bSortable': false, 'aTargets': [ 1 ] },
    	{ 'bSortable': false, 'aTargets': [ -1 ] },
    	{ 'bSortable': false, 'aTargets': [ -2 ] }
    ]

  $('#tbl-sectors').dataTable
	  "sDom": '<"top"fli>rt<"bottom"p><"clear">'
	  "sPaginationType": 'full_numbers'
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]

  $('#tbl-brand-owners').dataTable
	  "sDom": '<"top"fli>rt<"bottom"p><"clear">'
	  "sPaginationType": 'full_numbers'
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]

  $('#tbl-countries').dataTable
	  "sDom": '<"top"fli>rt<"bottom"p><"clear">'
	  "sPaginationType": 'full_numbers'
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
	
	$('#tbl-store-formats').dataTable
	  "sDom": '<"top"fli>rt<"bottom"p><"clear">'
	  "sPaginationType": 'full_numbers'
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
	$('#tbl-env-types').dataTable
	  "sDom": '<"top"fli>rt<"bottom"p><"clear">'
	  "sPaginationType": 'full_numbers'
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]

	$('#tbl-media-types').dataTable
	  "sDom": '<"top"fli>rt<"bottom"p><"clear">'
	  "sPaginationType": 'full_numbers'
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
	$('#tbl-media-locs').dataTable
	  "sDom": '<"top"fli>rt<"bottom"p><"clear">'
	  "sPaginationType": 'full_numbers'
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
	$('#tbl-media-vehicles').dataTable
	  "sDom": '<"top"fli>rt<"bottom"p><"clear">'
	  "sPaginationType": 'full_numbers'
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
	$('#tbl-promo-cals').dataTable
	  "sDom": '<"top"fli>rt<"bottom"p><"clear">'
	  "sPaginationType": 'full_numbers'
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
	$('#tbl-promo-types').dataTable
	  "sDom": '<"top"fli>rt<"bottom"p><"clear">'
	  "sPaginationType": 'full_numbers'
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
	$('#tbl-themes').dataTable
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
