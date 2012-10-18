jQuery ->
  
  stores = $('#audit_store_id').html()
  
  console.log(stores)
  $('#audit_retailer_id').change ->
    retailer = $('#audit_retailer_id :selected').text()
    
    escaped_retailer = retailer.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')

    options = $(stores).filter("optgroup[label=#{escaped_retailer}]").html()
    console.log(options)
    if options
      $('#audit_store_id').html(options)
      $('#audit_store_id').parent().show()      
    else
      $('#audit_store_id').empty()
      $('#audit_store_id').html("<option>Empty</option>")
