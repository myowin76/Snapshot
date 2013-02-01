jQuery ->
  
  $('.chosen-brand').chosen({no_results_text: "<a href='/brands/new' data-remote='true'>Add</a>:"})
  $('.chosen-category').chosen()
  $('.chosen-media-local').chosen()
  $('#brand-owner-id').chosen()

  $('.chosen-media-vehic').chosen({no_results_text: "<a href='/media_vehicles/new' data-remote='true'>Add</a>:"})
  $('.chosen-media-vehic-uploader').chosen({no_results_text: "<a href='/media_vehicles/new' data-remote='true'>Add</a>:"})
  
  $('.chosen-mv-uploader').chosen({no_results_text: "<a href='/media_vehicles/new' data-remote='true'>Add New</a>:"})
  
  
  ###$('.chosen-media-vehic').trigger('liszt:updated');###

  $('.chosen-media-type').chosen()
  $('.chosen-promo-type').chosen()
  $('.chosen-promo-cal').chosen()
  $('.chosen-theme').chosen()
  $('.brand_owner_ddl').chosen()
  $('#tbl-audits').dataTable
    "sPaginationType": 'full_numbers'
    "aoColumnDefs": [
      { 'bSortable': false, 'aTargets': [ 0 ] },
      { 'bSortable': false, 'aTargets': [ -1 ] },
      { 'bSortable': false, 'aTargets': [ -2 ] }
    ]


  $('form').on 'click', '.remove_field', (event) ->
    $(this).closest('.upload-field').remove()
    event.preventDefault()

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

  