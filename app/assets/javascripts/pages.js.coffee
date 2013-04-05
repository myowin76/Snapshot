jQuery.fn.dataTableExt.oSort["uk_date-asc"] = (a, b) ->
  ukDatea = $(a).text().split("/")
  ukDateb = $(b).text().split("/")
  x = (ukDatea[2] + ukDatea[1] + ukDatea[0]) * 1
  y = (ukDateb[2] + ukDateb[1] + ukDateb[0]) * 1
  (if (x < y) then -1 else ((if (x > y) then 1 else 0)))

jQuery.fn.dataTableExt.oSort["uk_date-desc"] = (a, b) ->
  ukDatea = $(a).text().split("/")
  ukDateb = $(b).text().split("/")
  x = (ukDatea[2] + ukDatea[1] + ukDatea[0]) * 1
  y = (ukDateb[2] + ukDateb[1] + ukDateb[0]) * 1
  (if (x < y) then 1 else ((if (x > y) then -1 else 0)))


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
  	"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
  	"sPaginationType": 'full_numbers'
  	"bStateSave": true
		aoColumnDefs: [
			aTargets: ["uk-date-column"]
			sType: "uk_date"
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
		"aLengthMenu": [[30, 60, 100, -1], [30, 60, 100, "All"]],
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
		"aLengthMenu": [[30, 60, 100, -1], [30, 60, 100, "All"]],
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
