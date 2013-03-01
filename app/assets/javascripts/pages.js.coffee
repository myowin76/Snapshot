jQuery ->


	$('#tbl-users').dataTable
		"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
		"sPaginationType": 'full_numbers',
		"bStateSave": true,
		"aoColumnDefs": [
    	{ 'bSortable': false, 'aTargets': [ -1 ] },
    	{ 'bSortable': false, 'aTargets': [ -2 ] }
    ]

	$('#tbl-categories').dataTable
		"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
		"sPaginationType": 'full_numbers',
		"bStateSave": true,
		"aoColumnDefs": [
    	{ 'bSortable': false, 'aTargets': [ -1 ] },
    	{ 'bSortable': false, 'aTargets': [ -2 ] }
    ]

  $('#tbl-unpublished').dataTable
  	"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
  	"sPaginationType": 'full_numbers',
  	"bStateSave": true,
  	"aoColumnDefs": [
  		{ 'bSortable': false, 'aTargets': [ 0 ] },
  		{ 'bSortable': false, 'aTargets': [ 1 ] },
    	{ 'bSortable': false, 'aTargets': [ -1 ] },
    	{ 'bSortable': false, 'aTargets': [ -2 ] }
    ]

  $('#tbl-sectors').dataTable
	  "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
	  "sPaginationType": 'full_numbers',
	  "bStateSave": true,
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]

  $('#tbl-brand-owners').dataTable
	  "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
	  "sPaginationType": 'full_numbers',
	  "bStateSave": true,
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
	$('#tbl-brands').dataTable
		"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
		"sPaginationType": 'full_numbers',
		"bStateSave": true,
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]  

  $('#tbl-countries').dataTable
	  "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
	  "sPaginationType": 'full_numbers',
	  "bStateSave": true,
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
	
	$('#tbl-store-formats').dataTable
		"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
	  "sPaginationType": 'full_numbers',
	  "bStateSave": true,
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
	$('#tbl-env-types').dataTable
	  "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
	  "sPaginationType": 'full_numbers',
	  "bStateSave": true,
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]

	$('#tbl-media-types').dataTable
	  "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
	  "sPaginationType": 'full_numbers',
	  "bStateSave": true,
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
	$('#tbl-media-locs').dataTable
	  "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
	  "sPaginationType": 'full_numbers',
	  "bStateSave": true,
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
	$('#tbl-media-vehicles').dataTable
	  "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
	  "sPaginationType": 'full_numbers',
	  "bStateSave": true,
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
	$('#tbl-promo-cals').dataTable
		"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
		"sPaginationType": 'full_numbers',
		"bStateSave": true,
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
	$('#tbl-promo-types').dataTable
	  "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
	  "sPaginationType": 'full_numbers'
	  "bStateSave": true,
	  "aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
	$('#tbl-themes').dataTable
		"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
		"sPaginationType": 'full_numbers',
		"bStateSave": true,
		"aoColumnDefs": [	  	
	  	{ 'bSortable': false, 'aTargets': [ -1 ] },
	  	{ 'bSortable': false, 'aTargets': [ -2 ] },
	  	{ 'bSortable': false, 'aTargets': [ -3 ] }
	  ]
