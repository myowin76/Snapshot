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
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require jquery.tokeninput

var snapshot = {
/*
  LayoutSwitcher: function(){

    $('.layout-switcher .layout-list').on('click', function(){
      parent = $(this).closest('.photo-view');
      if (!parent.hasClass('list')){
        if (parent.hasClass('grid')){
          parent.removeClass('grid');
        }
        parent.addClass('list');
      }
      
      if (!$(this).hasClass('active')){
        $('.layout-switcher .layout-grid').removeClass('active');
        $(this).addClass('active');    
      }
      return false;
    });

    $('.layout-switcher .layout-grid').on('click', function(){
      parent = $(this).closest('.photo-view');
      if (!parent.hasClass('grid')){
        if (parent.hasClass('list')){
          parent.removeClass('list');
        }
        parent.addClass('grid');
      }

      if (!$(this).hasClass('active')){
        $('.layout-switcher .layout-list').removeClass('active');
        $(this).addClass('active');
      }
      return false;
    });
  },
*/  
  Pagination: function(){
    $('.pagination a').live('click',function () {
      $.get(this.href, null, null, 'script');
      return false;
    });
  }

};

var photos = {
  generatePDF: function(){
    
    $('#export-pdf').on('click',function(){
      checkbox_array = $("input[name='photo_ids[]']:checked").serializeObject()['photo_ids[]'];
      if (checkbox_array == undefined) {
        alert("Please select the image");
        return false;
      }
      else{
        url = '/photos/generate_pdf.pdf?photo_ids=' + checkbox_array;
        $(this).attr('href', url);
      }  
    })
  },
  exportZIP: function(){
    
    $('#export-zip').on('click', function(e){
      checkbox_array = $("input[name='photo_ids[]']:checked").serializeObject()['photo_ids[]'];
      if (checkbox_array == undefined) {
        alert("Please select the image");
        return false;
      };
      url = '/photos/generate_zip?photo_ids=' + checkbox_array;
      $(this).attr('href', url);
    })
  },
  exportStorePhotos: function(){
    // $('#map-store-download').live('click',function(){
    //   alert('downloading');
    //   return false;
    // });
  }
};

$(document).ready(function() {


  
  // TO DO ## REFACFOR BY CREATING FUNCTIONS
  
  //snapshot.LayoutSwitcher();
  snapshot.Pagination();
  photos.generatePDF();
  photos.exportZIP();
  photos.exportStorePhotos();
  
  
  $(".photo-view").ajaxStart(function(){
    $(this).hide();
    $('#list-view .loading').show();
    
  }).ajaxStop(function() {
    $('#list-view .loading').hide();
    $(this).show();
  });

  $('.alert').click(function(){
      $(this).fadeOut(1000).remove();;
  });

  $('.go-top').on('click',function(e){
    e.preventDefault();
    $('html, body').animate({
      scrollTop: $(".tab-content").offset().top
    }, 500);
  });

  // $('.brand_owner_ddl').each(function(){

    $('.brand_owner_ddl').live('change', function(){
      var id = "#" + $(this).attr('id');
      var info = {}
      info['brand_owner_id'] = $(id).val();
      info['select_id'] = "#" + $(this).closest(".brands-owners-actions").next(".brands-actions").children().find(".chosen-brand").attr('id');
      
      $.ajax({
        url: '/photos/refresh_all_brands_dropdowns',
        type: "POST",
        dataType: 'script',
        data: info,
        success: function(data){

        }
      });
    });

    
    // $('.chosen-mv-uploader').next('.chzn-container').find('.chzn-results a').on('click', function(){
      
    //   alert($(this)); return false;
    
    // });
  // });

  // $('.brand_owner_ddl').change(function(e){
    
  //   var info = {}
  //   info = $(this).serializeObject();
  //   $.ajax({
  //     url: '/photos/refresh_all_brands_dropdowns',
  //     type: "POST",
  //     dataType: 'script',
  //     data: info,
  //     success: function(data){

  //     }
  //   });
  // });

  $('#brand_owner_id').on('change',function(e){
    
    var info = {}
    info = $('#brand_owner_id').serializeObject();
    $.ajax({
      url: '/photos/refresh_brands_dropdown',
      type: "POST",
      dataType: 'script',
      data: info,
      success: function(data){

      }
    });
  });

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

  
  $('#reviews').on('click', function(){

    if ($(".photo-view .photos-viewer input[name='photo_ids[]']:checked").length < 1){
      alert("Please select images");
      return false;
    }

    $(".photo-view .photos-viewer input[name='photo_ids[]']:not(:checked)").each(function(){
      $(this).closest('li').hide();
    });

    $(this).hide();
    $('#show-all').show();
    return false;

  });

  $('#show-all').on('click', function(){
    $(".photo-view .photos-viewer input[name='photo_ids[]']").closest('li').show();
    $(this).hide();
    $('#reviews').show();
    return false;
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

  $('#audit_created_at').datepicker(
    {
      dateFormat: 'dd/mm/yy',
      onClose: function(){
        $('#audit_created_at').blur(); //or .focusout();
      }
    }
  );
  
  // TO DO
  $('#store-view').live('click',function(){
    var info = {}
    info['categories'] = $('#category-group input[type="checkbox"]:checked').serializeObject()['search[categories][]']; 
    info['store_id'] = $('#hidden').val();
    $.ajax({
      url: '/stores/show_store_with_categories',
      type: "POST",
      dataType: 'script',
      data: info
    });
    return false;
  });

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

/*
	$('#checkAll').live('click',function(){
		$('.photos-viewer input[type="checkbox"]').each(function(){
			$(this).attr('checked', true)
		})
		return false;
	})

	$('#uncheckAll').live('click', function(){
		$('.photos-viewer input[type="checkbox"]').each(function(){
			$(this).attr('checked', false)
		})
		return false;
	})
*/

  $('.accordion').on('show hide', function(e){
    $(e.target)
      .siblings('.accordion-heading')
      .find('.accordion-toggle i')
        .toggleClass('icon-plus icon-minus');
  })  
   
	filterUI.init();
	
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

  init : function(el){
    "use strict";

    var that = this,
        $filter = $(el);

    // Checkboxes
    that.addLabelsForExistingCheckbox($filter);
    that.attachEventToCheckbox($filter);

    // Selects
    //that.addLabelsForExistingSelect($filter);
    //that.attachEventToSelect($filter);


    // Set Height
    //that.setHeight($filter);

  },


  /*
  el:
  */
  addLabelsForExistingCheckbox : function(el){

    var that = this,
        $checkedCheckboxes = $(el).find('input:checked');

    $checkedCheckboxes.each(function(){
      that.addLabel($(this));
    });

  },

  //addLabelsForExistingTextInput : function(){},
  //attachEventToTextInput : function(el){},


  addLabelsForExistingSelect : function(el){
    var that = this,
        $selectedOption = $(el).find(':selected');

    $selectedOption.each(function(){
      that.addLabel($(this).parent());
    });
  },

  /*
  el: jQ obj containing all selects
  */
  attachEventToSelect : function(el){
    var that = this,
        $filter = el;

    //Set event listener
    $filter.on('change', 'select', function(){

      that.removeLabel(this); // Remove previous label because you can only select one value

      if (($(this).val() !== undefined) || ($(this).val() !== 0)) {
        that.addLabel(this);
      }

    });// filter

  },


  /*
  el: expect #filter - jQ obj
  */
  attachEventToCheckbox : function(el){

    var that = this,
        $filter = el;

    //Set event listener
    $filter.on('change', 'input[type="checkbox"]', function(){

      if ($(this).attr('checked') !== undefined ){
        that.addLabel(this);
      }
      else{
        that.removeLabel(this);
      }
    });// filter

  },

  /*
  * setHeight - make height of $filter the same height asthe window
  * $filter: expect jQuery object of #filter
  */
  /*
  setHeight : function($filter){
    "use strict";

    var $win = $(window);

    $filter.css({
      'height': (parseInt( $win.height(),10) ) + 'px',
      'overflow-y': 'auto'
    });

  },
  */


  /*
  el : expect input
  return : location desc
  */
  getLabelDesc : function(el){

    console.log('dil', el);

    var elType = el.prop("tagName").toLowerCase();

    console.log(' elType',  elType);

    // If el === input, what is the type
    if (elType === "input") {
      elType = el.attr('type');
    };

    console.log(' elType',  elType);

    switch (elType) {
      case "select":
        //console.log('This is a select', el.find(':selected').attr('data-desc') );
        return $(el).find(':selected').attr('data-desc');
        break;
      case "checkbox":
        console.log('This is a checkbox', $(el).attr('data-desc'));
        return $(el).attr('data-desc');
        break;
      case "text":
        //console.log('This is a textbox', el);
        return $(el).val();
        break;
      default:
        console.log('No element type found.');
    }// switch

  },


  /*
  el: expect input[type=check] ***:DA TODO check for input type = checkbox
  */
  addLabel : function(el){
    "use strict";

    console.log('el', el);

    var that = this,
        $el = $(el),
        $labels = $el.parents('.accordion-group')
                  .find('.accordion-heading')
                  .find('.filter-tag-wrapper');

    console.log('test ', $el.parents('.accordion-group').find('.accordion-heading').find('.filter-tag-wrapper') );

    var dataDesc = that.getLabelDesc($el);

    console.log('dataDesc', dataDesc);
    console.log('dataDesc2', that.getLabelDesc($el) );

    //console.log('addlabel desc', dataDesc );

    // Add labels wrapper if it doesnt exist. ***TODO: Append only once fool
    if (! $labels.length ) {
      $el.parents('.accordion-group').find('.accordion-heading')
      .append('<div class="filter-tag-wrapper" />');
    };

    // Append label to labels
    $el.parents('.accordion-group')
      .find('.accordion-heading')
      .find('.filter-tag-wrapper')
      .append('<a data-id="' +
              $el.attr('id') +
              '" title="' + dataDesc +'" class="filter-tag"><i class="icon-white icon-remove"></i>' +
              dataDesc +
              '</a>');

      var $label = $el.parents('.accordion-group').find('.accordion-heading')
                  .find('[data-id="'+ $el.attr('id')  +'"]');

      this.attachEventToLabel($label);
  },

  /*
    except:
    el:
  */
  removeLabel : function(el){
    "use strict";

    var $el = $(el);

    $el.parents('.accordion-group')
    .find('.accordion-heading')
      .find('[data-id="'+ $el.attr('id')  +'"]')
      .fadeOut(300, function(){
        $(this).remove();
      });

  },


  attachEventToLabel : function(el){
    "use strict";

    var that = this,
        $el = $(el);

    //console.log('attach',$el);

    $el.parent().delegate("a", "click", function() {
      that.removeLabel( '#' + $(this).attr('data-id') );
      that.uncheckCheckbox( '#' + $(this).attr('data-id') );
    });

  },

  uncheckCheckbox : function(el){
    "use strict";

    var $el = $(el);
    $el.attr('checked', false);

  }

  // uncheck

};

jQuery(document).ready(function($) {
  filterUI.init('#search_form');
});
