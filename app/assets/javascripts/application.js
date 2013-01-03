// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require chosen-jquery
//= require jquery.ui.datepicker
//= require twitter/bootstrap
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require rails.validations

//= require_tree .

$(document).ready(function() {
  
  $('.search-form-actions .search').click(function(){
    $('#search_form').submit();
  })

  // TO DO
  $('.pagination a').live('click',function () {

    $.get(this.href, null, null, 'script');
    return false;
  });

  // TO DO
  // $('#store-view').live('click',function(){
  //   alert("test");
  //   categories_checkboxes = $('#category-group input[type="checkbox"]:checked').serializeObject()['search[categories][]']; 
    
  //   $.ajax({
  //     url: '/stores/show',
  //     type: "POST",
  //     dataType: 'script',
  //     data: categories_checkboxes
  //   })  
  // })
$('#audit_store_id').live('change',function(){
    store_id = $('#audit_store_id').serializeObject();
    $.ajax({
      url: '/stores/get_store_details',
      type: "POST",
      dataType: 'script',
      data: store_id,
    })
  })

$('#audit_retailer_id').live('change',function(){
    retailer_id = $('#audit_retailer_id').serializeObject();
    $.ajax({
      url: '/audits/refresh_store_dropdown',
      type: "POST",
      dataType: 'script',
      data: retailer_id
    })
  })

  $('#export-zip').click(function(e){
    checkbox_array = $("input[name='photo_ids[]']:checked").serializeObject()['photo_ids[]'];
    
    if (checkbox_array == undefined) {
      alert("Please select the image");
      return false;
    };
    url = '/photos/generate_zip?photo_ids=' + checkbox_array;
    $(this).attr('href', url);
  })

  $('#export-pdf').click(function(){
    checkbox_array = $("input[name='photo_ids[]']:checked").serializeObject()['photo_ids[]'];
    
    if (checkbox_array == undefined) {
      alert("Please select the image");
      return false;
    };

    url = '/photos/generate_pdf.pdf?photo_ids=' + checkbox_array;
    $(this).attr('href', url);

  })

  $('#publish_multiple').click(function(){
    checkbox_array = $("input[name='photo_ids[]']:checked").serializeObject()['photo_ids[]'];
    
    if (checkbox_array == undefined) {
      alert("Please select the image");
      return false;
    };
  })
  
  $('#audit_retailer_id').chosen({no_results_text: "No results matched"})
  // $('#store_retailer_id').chosen({no_results_text: "No results matched"})
  // $('#store_country_id').chosen({no_results_text: "No results matched"})
  // $('.audit_categories').chosen({no_results_text: "No results matched"})
  // $('.audit_brands').chosen({no_results_text: "No results matched"})
  
	$('.clear-form').click(function(){
		$('#search_form select').val('');
    $('#search_form input:text').val('');
		$('#search_form input:checkbox').attr('checked',false);
		// $('.accordion-heading').find('.labels').remove();
		return false;
	});

 $('#search_form input[type=checkbox]').live('click',function(){
    sectores_checkboxes = $('#search_form input[type=checkbox]:checked').serializeObject();
    $.ajax({
      url: '/photos/check_counts',
      type: "POST",
      dataType: 'script',
      data: sectores_checkboxes
    })
 });

 $('#sector-group .accordion-inner input[type=checkbox]').live('click',function(){
    sectores_checkboxes = $('#sector-group .accordion-inner input[type=checkbox]:checked').serializeObject();
    $.ajax({
      url: '/photos/refresh_retailers',
      type: "POST",
      dataType: 'script',
      data: sectores_checkboxes
    })
 });

 $('#brand-owners-group .accordion-inner input[type=checkbox]').live('click',function(){
    brand_owners_checkboxes = $('#brand-owners-group .accordion-inner input[type=checkbox]:checked').serializeObject();
    $.ajax({
      url: '/photos/refresh_brands',
      type: "POST",
      dataType: 'script',
      data: brand_owners_checkboxes
    })
  });

  $('#store-audit-select').change(function(){
    audit_id = $('#store-audit-select').serializeObject();
    
    $.ajax({
      url: '/stores/refresh_store_view_categories',
      type: "POST",
      dataType: 'script',
      data: audit_id
    })
  })    

  

	$('#checkAll').live('click',function(){
		$('.photo-grid input[type="checkbox"]').each(function(){
			$(this).attr('checked', true)
		})
		return false;
	})

	$('#uncheckAll').live('click', function(){
		$('.photo-grid input[type="checkbox"]').each(function(){
			$(this).attr('checked', false)
		})
		return false;
	})
  
  


  $('.accordion').on('show hide', function(e){
    $(e.target).siblings('.accordion-heading').find('.accordion-toggle i').toggleClass('icon-plus icon-minus');
  })  
   

	// filterUI.init();
	
 });
ClientSideValidations.formBuilders['SimpleForm::FormBuilder'] = {
  add: function(element, settings, message) {
    if (element.data('valid') !== false) {
      var wrapper = element.closest(settings.wrapper_tag);
      wrapper.parent().addClass(settings.wrapper_error_class);
      var errorElement = $('<' + settings.error_tag + ' class="' + settings.error_class + '">' + message + '</' + settings.error_tag + '>');
      wrapper.append(errorElement);
    } else {
      element.parent().find(settings.error_tag + '.' + settings.error_class).text(message);
    }
  },
  remove: function(element, settings) {
    var wrapper = element.closest(settings.wrapper_tag + '.' + settings.wrapper_error_class);
    wrapper.removeClass(settings.wrapper_error_class);
    var errorElement = wrapper.find(settings.error_tag + '.' + settings.error_class);
    errorElement.remove();
  }
};

/* dils js */

function initAccordion(el){
  "use strict";
  var $el = $(el);
  $el.accordion({
    header: "h5",
    heightStyle: "auto",
    animate: "bounce"
  });
}

//  Fix position the sidebar
// ============================================
function fixPosElement(el){

  "use strict";
  var $el = $(el);

  var top = $el.offset().top - parseFloat($el.css('marginTop').replace(/auto/, 0));

  $(window).scroll(function (event) {
    // what the y position of the scroll is
    var y = $(this).scrollTop();

    // whether that's below the form
    if (y >= top) {
      // if so, ad the fixed class
      $el.addClass('fixed');
    } else {
      // otherwise remove it
      $el.removeClass('fixed');
    }
  });
}

//  Filter UI object
// ============================================
var filterUI = {

  init : function(){
    "use strict";

    var that = this,
        $filters = $('#search_form');

    $filters.on('change', 'input', function(){

      if ( $(this).attr('checked') !== undefined ){
        that.addLabel(this);
      }
      else{
        that.removeLabel(this);
      }

    });
  },

  addLabel : function(el){
    "use strict";

    var $el = $(el);

   //console.log($el.parents('.accordion-group').find('.accordion-heading').find('.accordion-toggle') );
   //console.log($el.parent().text());
    if (! $el.parents('.accordion-group').find('.accordion-heading').find('.labels').length ) {
      $el.parents('.accordion-group').find('.accordion-heading')
      .append('<div class="labels" />');
    };


    $el.parents('.accordion-group').find('.accordion-heading').find('.labels')
    .append('<a data-id="' +
            $el.attr('id') +
            '" title="' + jQuery.trim($el.parent().text()) +'" class="label"><i class="icon-white icon-remove"></i>' +
            $el.parent().text() +
            '</a>');


      var $label = $el.parents('.accordion-group').find('.accordion-heading')
                  .find('[data-id="'+ $el.attr('id')  +'"]');

      console.log('label', $label);

      this.attachEventToLabel($label);

  },

  removeLabel : function(el){
    "use strict";

    var $el = $(el);

    $el.parents('.accordion-group')
    .find('.accordion-heading')
      .find('[data-id="'+ $el.attr('id')  +'"]')
      .remove();


  },

  attachEventToLabel : function(el){
    var that = this,
        $el = $(el);

    console.log('attach',$el);

    $el.parent().delegate("a", "click", function() {
      that.removeLabel( '#' + $(this).attr('data-id') );
      that.uncheckCheckbox( '#' + $(this).attr('data-id') );
      
    });

  },

  uncheckCheckbox : function(el){

    var $el = $(el);
    $el.attr('checked', false);

  }


};

