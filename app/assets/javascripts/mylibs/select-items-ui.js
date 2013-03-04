/*
  desc: list-ui - select/deselect items
  author: DA
*/

jQuery(document).ready(function($) {

  var ListUI = {

    config : {
      main           : "#main",
      photos         : "#photos-viewer > li",
      
      photoInner      : ".viewer-inner",
      selectClass     : "selected",

      areAllSelected  : "no",
      selectAllEl     : "#checkAll",
      selectAllText   : "Select All",
      unSelectAllText : "Unselect All",

      hideSelectedText : "Filter Selected",
      showSelectedText : "Show All"
      
    },

    init : function(){
      //console.log('init');
      
      //console.log(this.config.$main);
      //console.log(this.config.$photos);
      //console.log(this.config.$photoItems);
      //this.initCheckBoxes();

      this.initSelectItem();
      this.initSelectAllItems();
      this.exportZIP();
      this.generatePDF();
      this.filterSelected();

    },


    exportZIP: function(){
      
      $('#export-zip').on('click', function(e){
        
        //e.preventDefault();

        var $checkedItems = $("#photos-viewer :checked"),
            chkboxArr = [];

        if ($checkedItems.length) {

          for (var i = $checkedItems.length - 1; i >= 0; i--) {
            chkboxArr.push($checkedItems[i].value );
          };

          url = '/photos/generate_zip?photo_ids=' + chkboxArr.join(',');
          $(this).attr('href', url);  

        }
        else{
          alert("Please select an image");
          return false;
        }

      })

    },


    generatePDF: function(){
      
      $('#export-pdf').on('click',function(e){

        //e.preventDefault();

        var checkedItems = $("#photos-viewer :checked"),
            chkboxArr = [];

        if ( checkedItems.length ){

          for (var i = checkedItems.length - 1; i >= 0; i--) {
            chkboxArr.push(checkedItems[i].value );
          };

          url = '/photos/generate_pdf.pdf?photo_ids=' + chkboxArr.join(',');
          $(this).attr({'href': url, 'target': '_blank'});

        }else{

          alert("Please select an image");
          return false;
        };

      })//on
    },

    filterSelected : function(){

      var that = this;

      //console.log( $checkedItems, $checkedItems.length);

      $('#reviews').on('click', function(e){

        e.preventDefault();

        var $unCheckedItems = $("#photos-viewer input:not(:checked)");
        var $checkedItems = $("#photos-viewer input:checked");

        if ( $checkedItems.length ) {

          if ( $(this).attr('data-filtered') === 'show' ) {
            $unCheckedItems.parents('li').hide();
            $(this).attr('data-filtered' , 'hide');
            $(this).text( that.config.showSelectedText );
          }
          else{
            $unCheckedItems.parents('li').show();
            $(this).attr('data-filtered' , 'show');
            $(this).text( that.config.hideSelectedText );
          }

        }
        else{
          alert("Please select an image");
        }



      });

    },


    initSelectItem : function(){
      var that = this;

      //console.log('initSelectItem');
      $(this.config.photos).on('click', this.config.photoInner , function(evt){
        
        // Dont select item if click target is a link <a> 
        if ( !$(evt.target).is('a, :checkbox, .expand, img') ) {
          console.log( $(evt.target) ); 
          evt.preventDefault();
          that.selectItem(this);  
        };// if

        
      });
    },


    // el should be this.config.photoInner
    selectItem : function(el){
      console.log('selectItem', el);

      var that = this,
          $chkbox =  $(el).find(':checkbox')

      $chkbox.attr('checked', !$chkbox.attr('checked') );
      $(el).toggleClass( that.config.selectClass );
    },



    /*
      Select/Deselect All - toggle checkbox and class 
    */
    initSelectAllItems : function(){

      var that = this,
      $selectAllEl = $(that.config.selectAllEl);
  

      $(that.config.main).on('click', that.config.selectAllEl, function(e){
        
        e.preventDefault();

        that.toggleSelectAllText();

        if ( $(that.config.selectAllEl).attr('data-select-all') === "false" ) {
          
          $(that.config.photos).find(':checkbox').attr('checked', 'checked');
          $(that.config.photoInner).addClass(that.config.selectClass);

          $(that.config.selectAllEl).attr('data-select-all', "true");
        }
        else{
          $(that.config.photos).find(':checkbox').attr('checked', null); 
          $(that.config.photoInner).removeClass(that.config.selectClass);

          $(that.config.selectAllEl).attr('data-select-all', "false")
        }
      
      });
    },


    toggleSelectAllText : function(){
      //console.log('toggleSelectAllText');
      var that = this,
          $selectAllEl = $(that.config.selectAllEl);

      //console.log('B', $selectAllEl.text());
      if ( $(that.config.selectAllEl).attr('data-select-all') === "false" ) {
        //console.log('t', that.config.selectAllText);
        $selectAllEl.text(that.config.unSelectAllText); 
      }
      else{
        //console.log('f', that.config.selectAllText);
        $selectAllEl.text(that.config.selectAllText);
      }

    },

  };


  // Stuff to do as soon as the DOM is ready;
  ListUI.init();
});


