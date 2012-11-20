jQuery ->
  ###$('#audit_store_id').parent().hide()###
  store = $('#audit_store_id').html()
  $('#audit_retailer_id').change ->
    retailer = $('#audit_retailer_id :selected').text()
    escaped_retailer = retailer.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(store).filter("optgroup[label='#{escaped_retailer}']").html()
    if options
      $('#audit_store_id').html(options)
      $('#audit_store_id').parent().show()
    else
      $('#audit_store_id').parent().show()
      options = "<option>No Stores Found</option>"
      $('#audit_store_id').html(options)
      

  $('.created_at').datepicker({dateFormat: 'dd/mm/yy'})
  