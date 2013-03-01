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
      unSelectAllText : "Unselect All"
      
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
    },


    exportZIP: function(){
      
      $('#export-zip').on('click', function(e){
        
        e.preventDefault();

        var checkedItems = $("#photos-viewer :checked");

        console.log( checkedItems );

        var checkbox_array = [];


        
        //checkedItems.each(function(){ alert( this.value ) } );

        for (var i = checkedItems.length - 1; i >= 0; i--) {
          console.log( checkedItems[i] );
          checkbox_array.push(checkedItems[i].value );
        };

        //checkbox_array.push( checkedItems.each(function(){ return $(this).val() } ) );


        console.log('dil', checkbox_array );
        
        
        //checkbox_array = $("#photos-viewer :checked") ;
        
        console.log('xxx', checkbox_array );

        if (checkbox_array == undefined) {
          alert("Please select the image");
          return false;
        }
        
        url = '/photos/generate_zip?photo_ids=' + checkbox_array;
        $(this).attr('href', url);  
      
        


      })

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


