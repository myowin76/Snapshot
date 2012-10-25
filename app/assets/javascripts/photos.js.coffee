jQuery ->
	$('#photo-list').dataTable
  "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
  "sPaginationType": "bootstrap"

	$('#search_fromDate').datepicker({ dateFormat: 'dd/mm/yy'})
	$('#search_toDate').datepicker({ dateFormat: 'dd/mm/yy'})

jQuery ->
  $('#search_location_id').parent().hide()
  location = $('#search_location_id').html()
  $('#search_country_id').change ->
    country = $('#search_country_id :selected').text()
    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = "<option>All</option>"
    options = options + $(location).filter("optgroup[label='#{escaped_country}']").html()
    if options
      $('#search_location_id').html(options)
      $('#search_location_id').parent().show()
    else
      $('#search_location_id').empty()
      $('#search_location_id').parent().hide()
      
