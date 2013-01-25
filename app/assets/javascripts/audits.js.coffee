jQuery ->
  $('.chosen-category').chosen()
  $('.chosen-brand').chosen()
  $('.chosen-media-local').chosen()
  $('.chosen-media-vehic').chosen()
  $('.chosen-media-type').chosen()
  $('.chosen-promo-type').chosen()
  $('.chosen-promo-cal').chosen()
  $('.chosen-theme').chosen()

  $('#tbl-audits').dataTable
    "sDom": '<"top"fli>rt<"bottom"p><"clear">'
    "sPaginationType": 'full_numbers'
    "aoColumnDefs": [
      { 'bSortable': false, 'aTargets': [ 0 ] },
      { 'bSortable': false, 'aTargets': [ -1 ] },
      { 'bSortable': false, 'aTargets': [ -2 ] }
    ]

  ###$('.category-tokens').tokenInput '/categories.json'
    tokenDelimiter: ","
    theme: 'facebook'
    prePopulate: $('.category-tokens').data('load')###
  ###$('#audit_store_id').parent().hide()###
  $('form').on 'click', '.remove_field', (event) ->
    $(this).closest('.upload-field').remove()
    event.preventDefault()
  ###$('form').on 'click', '.add_field', (event) ->
    $(this).before($(this).closest('.upload-field'))
    event.preventDefault()    ###
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

  