jQuery ->
	$('#photo-list').dataTable
  "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
  "sPaginationType": "bootstrap"

	$('#search_fromDate').datepicker()
	$('#search_toDate').datepicker()