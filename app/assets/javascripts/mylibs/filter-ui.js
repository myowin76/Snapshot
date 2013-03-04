//  Filter UI object: used for checkboxes only at the moment
// ============================================
var filterUI = {

  init : function(el){
    "use strict";

    var that = this,
        $filter = $(el);

    that.addLabelsForExistingCheckbox($filter);
    that.attachEventToCheckbox($filter);
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
  el : expect input
  return : location desc
  */
  getLabelDesc : function(el){



    var elType = el.prop("tagName").toLowerCase();

    // If el === input, what is the type
    if (elType === "input") {
      elType = el.attr('type');
    };


    switch (elType) {
      case "select":
        //console.log('This is a select', el.find(':selected').attr('data-desc') );
        return $(el).find(':selected').attr('data-desc');
        break;
      case "checkbox":
        //console.log('This is a checkbox', $(el).attr('data-desc'),el );
        return $(el).attr('data-desc');
        break;
      case "text":
        //console.log('This is a textbox', el);
        return $(el).val();
        break;
      default:
        //console.log('No element type found.');
    }// switch

  },


  /*
  el: expect input[type=check] ***:DA TODO check for input type = checkbox
  */
  addLabel : function(el){
    "use strict";

    //console.log('el', el);

    var that = this,
        $el = $(el),
        $labels = $el.parents('.accordion-group')
                  .find('.accordion-heading')
                  .find('.filter-tag-wrapper');

    //console.log('test ', $el.parents('.accordion-group').find('.accordion-heading').find('.filter-tag-wrapper') );

    var dataDesc = that.getLabelDesc($el);

    //console.log('dataDesc', dataDesc);
    //console.log('dataDesc2', that.getLabelDesc($el) );

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