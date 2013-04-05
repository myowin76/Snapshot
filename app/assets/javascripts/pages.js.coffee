jQuery.extend jQuery.fn.dataTableExt.oSort,
  "date-eu-pre": (date) ->
    date = date.replace(" ", "")
    if date.indexOf(".") > 0
      
      #date a, format dd.mn.(yyyy) ; (year is optional)
      eu_date = date.split(".")
    else
      
      #date a, format dd/mn/(yyyy) ; (year is optional)
      eu_date = date.split("/")
    
    #year (optional)
    if eu_date[2]
      year = eu_date[2]
    else
      year = 0
    
    #month
    month = eu_date[1]
    month = 0 + month  if month.length is 1
    
    #day
    day = eu_date[0]
    day = 0 + day  if day.length is 1
    (year + month + day) * 1

  "date-eu-asc": (a, b) ->
    (if (a < b) then -1 else ((if (a > b) then 1 else 0)))

  "date-eu-desc": (a, b) ->
    (if (a < b) then 1 else ((if (a > b) then -1 else 0)))


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
  	"bStateSave": true
  	"aoColumnDefs": [
  		{ "sType": "date-uk-asc", "aTargets": [4] }
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
