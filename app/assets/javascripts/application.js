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
//= require autocomplete-rails
//= require jquery.tokeninput
//= require jquery.ui.datepicker
//= require twitter/bootstrap
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap

//= require_tree .


$(document).ready(function() {
 	
  $('#audit_retailer_id').chosen({no_results_text: "No results matched"})
  // $('#store_retailer_id').chosen({no_results_text: "No results matched"})
  // $('#store_country_id').chosen({no_results_text: "No results matched"})
  // $('.audit_categories').chosen({no_results_text: "No results matched"})
  // $('.audit_brands').chosen({no_results_text: "No results matched"})
  
	$('.clear-form').click(function(){
		$('#search_form input:text').val('');
		$('#search_form input:checkbox').attr('checked',false);
		$('.accordion-heading').find('.labels').remove();
		$('#search_form').submit();
	})
  $('a.submit').click(function(){
    $('#search_form').submit();
  })
	
	$('#checkAll').click(function(){
		$('.table-striped input[type="checkbox"]').each(function(){
			$(this).attr('checked', true)
		})
		return false;
	})

	$('#uncheckAll').click(function(){
		$('.table-striped input[type="checkbox"]').each(function(){
			$(this).attr('checked', false)
		})
		return false;
	})
  $('.accordion').on('show hide', function(e){
    $(e.target).siblings('.accordion-heading').find('.accordion-toggle i').toggleClass('icon-plus icon-minus');
  })  
   

	filterUI.init();
	
 });


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
      $('#search_form').submit();
    });

  },

  uncheckCheckbox : function(el){

    var $el = $(el);
    $el.attr('checked', false);

  }


};