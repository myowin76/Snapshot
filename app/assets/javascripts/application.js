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
//= require jquery-fileupload
//= require_tree ./gmaps4rails
//= require_tree ./libs
//= require_tree ./mylibs
//= require_tree ./admin
// require underscore
// require backbone
//= require jquery.validate.min
// require backbone/snapshot
// require_tree .
// require jquery-fileupload/vendor/tmpl
// require jquery.tokeninput
//= require pages
//= require audits
//= require retailers
//= require photos
//= require stores
//= require save_searches
//= require_self

var snapshot = {
  
  Pagination: function(){

    $('.content .will-page .pagination a').live('click',function (e) {
      e.preventDefault();
      $.get(this.href, null, null, 'script');
      $('html, body').animate({
        scrollTop: $(".photo-view").offset().top
      }, 500);

      // return false;

    });
  }
};

  $(document).ready(function() {

  // new Snapshot.Router;
  // Backbone.history.start();
  // Snapshot.photos = new Snapshot.Collections.Photos;
  // Snapshot.photos.fetch().then(function(){
  //   new Snapshot.Views.Snapshot({ collection: Snapshot.photos })
  // });

  // window.Sector = Backbone.Model.extend({});
  // window.SectorView = Backbone.View.extend({
  //   initialize: function(){
  //     this.template = _.template($('.page-header').html());
  //   }, 
  //   render: function(){
  //     var renderedContent = this.template(this.model.attributes);
  //     $(this.el).html(renderedContent);
  //     return this;
  //   }

  // });
// $.getJSON('/sectors.json', function(data) {
//   var items = [];
  
//   $.each(data, function(key, val) {
//     console.log (val.id + ':'+ val.name);
//     items.push('<li id="' + val.id + '">' + val.name + '</li>');
//   });
 
//   $('<div />', {
//     'class': 'accordion-inner',
//     html: items.join('')
//   }).appendTo('#sector-accord');
// });
// $.ajax({
//   url: "http://localhost:3000/lists/3",
//   dataType: "json",
//   type: "GET",
//   processData: false,
//   contentType: "application/json"
// });


  // $('#search_form').submit();

  $('#search_fromDate').datepicker({ 
    dateFormat: 'dd/mm/yy',
    onClose: function( selectedDate ){
      $( "#search_toDate" ).datepicker( "option", "minDate", selectedDate );
    }
  });
  $('#search_toDate').datepicker({ 
    dateFormat: 'dd/mm/yy',
    onClose: function( selectedDate ) {
      $( "#search_fromDate" ).datepicker( "option", "maxDate", selectedDate );
    }
  })

  snapshot.Pagination();


  $('.nav-tabs li a').live('click', function (e) {
    google.maps.event.trigger(map, 'resize');
  });

  $('#viewMap').live('click', function () {
    Gmaps.loadMaps();
  });

  

  $(".photo-view").ajaxStart(function(){
    $(this).hide();
    $('#list-view .loading').show();
    
  }).ajaxStop(function() {
    $('#list-view .loading').hide();
    $(this).show();
  });


  $('.alert').click(function(){
      $(this).fadeOut(1000).remove();
  });

  $('img.expend').live('click', function(){
    
    $("#photo-details").toggleClass('is-active');
  });

  $('.go-top').on('click',function(e){
    
    e.preventDefault();
    $('html, body').animate({
      scrollTop: $(".tab-content").offset().top
    }, 500);
  });





  $('.edit_audit .brands-actions .chosen-brand').each(function(){
      var brands_ddl_id = "#" + $(this).attr('id');
      var brand_ids = new Array();
      
      $(brands_ddl_id).find('option:selected').each(function(){
        brand_ids.push($(this).val());  
      });
      
      var info = {}
      info['brand_owners_ddl_id'] = $(this).closest(".brands-actions").prev(".brands-owners-actions").children(".brand_owner_ddl").attr("id");
      info['brands_ddl_id'] = brands_ddl_id;
      info['brand_ids'] = brand_ids;

      $.ajax({
        url: '/photos/preselect_brand_owners',
        type: "POST",
        dataType: 'script',
        data: info,
        success: function(data){

        }
      });
  });


  $('#main .brand_owner_ddl').live('change', function(){
    var id = "#" + $(this).attr('id');
    var pre_selected_brand_ids = new Array();
    var brand_dropdown_id = "#" + $(this).closest(".brands-owners-actions").next(".brands-actions").children().find(".chosen-brand").attr('id');
    var info = {}
    $(brand_dropdown_id).find('option:selected').each(function(){
        pre_selected_brand_ids.push($(this).val());  
      });
    
    info['brand_owner_id'] = $(id).val();
    info['pre_selected_brand_ids'] = pre_selected_brand_ids;
    
    info['select_id'] = brand_dropdown_id;
    $.ajax({
      url: '/photos/refresh_all_brands_dropdowns',
      type: "POST",
      dataType: 'script',
      data: info,
      success: function(data){

      }
    });
  });



///////////////////////////////
  $('.chosen-brand').live('change', function(){

    var id = "#" + $(this).attr('id');
    var info = {}
    info['brand_ids'] = $(id).val();
    info["brand_owner_ddl_id"] = $(this).closest(".brands-actions").prev(".brands-owners-actions").children(".brand_owner_ddl").attr("id");
    // info['pre_selected_brand_ids'] = pre_selected_brand_ids;
    $.ajax({
      url: '/photos/update_brand_owners_dropdown',
      type: "POST",
      dataType: 'script',
      data: info,
      success: function(data){

      }
    });
  })
  

  $("#store_format_help")
    .popover({
            offset: 10
        })
    .click(function(e) { 
        e.preventDefault(); 
    });


  //********** TO DO
  // IF ANY CHECKBOX IN ACCORDION IS CHECKED, THEN
  // THE ACCORDION SHOULD BE OPEN
  $('.search-form-actions .search').click(function(){
    $('#search_form').submit();
  });

  


  $('#length').live('change',function(){
    var info = {}
    info['per_page'] = $(this).val();
    info[''] = $('#search_form').serializeObject();
    $.ajax({
      url: '/',
      type: "POST",
      dataType: 'script',
      data: info,
      success: function(data){
        $('#length').val(info['per_page']);
        $('.pagination a').each(function(){
          var _href = $(this).attr("href");
          $(this).attr("href", _href + "&per_page=" + info['per_page']);
        });
      }
    })
  });



  //## sort by
  $('#sort_by').change(function(){
    $('#search_form').submit();
  });



  $('#audit_audit_date').datepicker(
    {
      dateFormat: 'dd/mm/yy',
      onClose: function(){
        $('#audit_audit_date').blur(); //or .focusout();
      }
    }
  );

  
  // TO DO
  $('#store-view').live('click',function(){
    var info = {}
    info['categories'] = $('#category-group input[type="checkbox"]:checked').serializeObject()['search[categories][]']; 
    info['store_id'] = $('#hidden_store').val();
    $.ajax({
      url: '/stores/show_store_with_categories',
      type: "POST",
      dataType: 'script',
      data: info
    });
    return false;
  });



  // $('#audit_store_id').chosen({no_results_text: "<a href='/stores/new'>New Store</a>:"})
  
  $('#audit_store_id').live('change',function(){
    store_id = $('#audit_store_id').serializeObject();
    $.ajax({
      url: '/stores/get_store_details',
      type: "POST",
      dataType: 'script',
      data: store_id
    })
  });




  $('#audit_retailer_id').live('change',function(){
    retailer_id = $('#audit_retailer_id').serializeObject();
    $.ajax({
      url: '/audits/refresh_store_dropdown',
      type: "POST",
      dataType: 'script',
      data: retailer_id
    })
  });




  $('#publish_checked').click(function(){
    var info = {}
    checkbox_array = $("input[name='photo_ids[]']:checked").serializeObject()['photo_ids[]'];
    
    if (checkbox_array == undefined) {
      alert("Please select the image");
      return false;
    }
    info['checkbox_array'] = checkbox_array
    $.ajax({
      url: '/photos/publish_multiple',
      type: "POST",
      dataType: 'script',
      data: info
    });
    // return false;

  });
  $('#delete_checked').live("click", function(){
    var info = {}
    checkbox_array = $("input[name='photo_ids[]']:checked").serializeObject()['photo_ids[]'];
    
    if (checkbox_array == undefined) {
      alert("Please select the image");
      return false;
    }
    info['checkbox_array'] = checkbox_array
    $.ajax({
      url: '/photos/delete_multiple',
      type: "POST",
      dataType: 'script',
      data: info
    });
    // return false;
  });
  


  $('#audit_retailer_id').chosen({no_results_text: "No results matched"})
  $('.chosen-brand-owner').chosen()
  // $('#store_retailer_id').chosen({no_results_text: "No results matched"})
  // $('#store_country_id').chosen({no_results_text: "No results matched"})
  // $('.audit_categories').chosen({no_results_text: "No results matched"})
  // $('.audit_brands').chosen({no_results_text: "No results matched"})




	$('.clear-form').click(function(){
		$('#search_form select').val('');
    $('#search_form input:text').val('');
		$('#search_form input:checkbox').attr('checked',false);
		$('.accordion-heading').find('.filter-tag-wrapper').remove();
		return false;
	});




 // $('#search_form input[type=checkbox]').live('click',function(){
 //    sectores_checkboxes = $('#search_form input[type=checkbox]:checked').serializeObject();
 //    $.ajax({
 //      url: '/photos/check_counts',
 //      type: "POST",
 //      dataType: 'script',
 //      data: sectores_checkboxes
 //    })
 // });


  $('#sector-group .accordion-inner input[type=checkbox]').live('click',function(){
    
    sectores_checkboxes = $('#sector-group .accordion-inner input[type=checkbox]:checked').serializeObject();
    $.ajax({
      url: '/photos/refresh_retailers',
      //url: '/photos/refresh_filters',
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

  // $('#store-audit-select').change(function(){
  //   audit_id = $('#store-audit-select').serializeObject();
    
  //   $.ajax({
  //     url: '/stores/refresh_store_view_categories',
  //     type: "POST",
  //     dataType: 'script',
  //     data: audit_id
  //   })
  // })    



  $('.accordion').on('show hide', function(e){
    $(e.target).siblings('.accordion-heading')
      .find('.accordion-toggle i').toggleClass('icon-plus icon-minus');
  });

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






/*
    Lazy Load
*/

function initLazyLoad(el){
  if (el) {

    // console.log( $(el).length + " lazy load elements" );

    $(el).show().lazyload({
      effect : "fadeIn"
    });
  }

  else{
    //console.log("Error: No element found!");
  }

}

jQuery(document).ready(function($) {

  // initLazyLoad("img.lazy");
  
  // $("img.lazy").lazyload({ 
  //   effect : "fadeIn",
  //   event : "click"
  // });
  
  
  // $('.pagination a').live('click',function () {
  //   alert('hello');
  //   $("img.lazy").lazyload();  
  // });


});
