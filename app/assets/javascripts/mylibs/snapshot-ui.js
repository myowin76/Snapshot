/*
  desc: list-ui - select/deselect items 
  author: DA
*/
jQuery(document).ready(function($) {

  var ListUI = {

    config : {
      $main           : $("#main"),
      $photos         : $(".mod-photos > .photos-wrapper"),
      $photoItems     : $(".mod-photos .photo-item"),
      photoInner      : ".photo-inner",
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


      this.initSelectItem();
      this.initSelectAllItems();
    },


    initSelectAllItems : function(){
      var that = this,
      $selectAllEl = $(that.config.selectAllEl);
      //console.log('initSelectAllItems');
      this.config.$main.on('click', this.config.selectAllEl, function(evt){
        evt.preventDefault();
        $selectAllEl.data("areAllSelected", ($selectAllEl.data("areAllSelected") == "yes" ? "no" : "yes") );
        that.selectAllItems();
      } );
    },


    selectAllItems : function(){

      //console.log('selectAllItems');
      
      var that = this,
          $selectAllEl = $(that.config.selectAllEl);
          

      that.config.$photoItems.each(function(){

        that.toggleSelectAllText();
        that.toggleItemCheckbox(  $(this).find(that.config.photoInner),  $selectAllEl.data("areAllSelected") );
        that.toggleItemClass(     $(this).find(that.config.photoInner),  $selectAllEl.data("areAllSelected") );

      });

      
      //console.log("af", $selectAllEl.data("areAllSelected") );
      
    },

    toggleSelectAllText : function(){
      //console.log('toggleSelectAllText');
      var that = this,
          $selectAllEl = $(that.config.selectAllEl);

      //console.log('B', $selectAllEl.text());

      if ( $selectAllEl.data("areAllSelected") == "yes" ) {
        //console.log('t', that.config.selectAllText);
        $selectAllEl.text(that.config.unSelectAllText); 
      }
      else{
        //console.log('f', that.config.selectAllText);
        $selectAllEl.text(that.config.selectAllText);
      }

    },

    initSelectItem : function(){
      var that = this;

      //console.log('initSelectItem');
      this.config.$photos.on('click', this.config.photoInner , function(evt){
        
        // Dont select item if click target is a link <a> 
        if ( !$(evt.target).is('a') ) {
          //console.log( $(evt.target) ); 
          evt.preventDefault();
          that.selectItem(this);  
        };// if

        
      });
    },



    // el should be this.config.photoInner
    selectItem : function(el){
      //console.log('selectItem', el);

      this.toggleItemCheckbox(el);
      this.toggleItemClass(el);
    },

    toggleItemCheckbox : function(el, override){
      //console.log('toggleItemCheckbox');

      // ***** TODOD
      //console.log('dil', override);

      var $checkbox = $(el).find(':checkbox');
      
      if (override) {
        if (override == "yes") {   
          $checkbox.attr('checked' , 'checked' );  
        }
        else{ 
          $checkbox.attr('checked' , null );  
        };
      }
      else{
        $checkbox.attr('checked' , !$checkbox.attr('checked') );  
      }
      
    },

    toggleItemClass : function(el, override){
      //console.log('toggleItemClass');
      if (override) {
        if (override == "yes") { 
          $(el).addClass( this.config.selectClass );  
        }
        else{ 
          $(el).removeClass( this.config.selectClass );  
        };
      }
      else{
        $(el).toggleClass( this.config.selectClass );  
      }
      
    }


  };


  // Stuff to do as soon as the DOM is ready;
  ListUI.init();
});





/*
  desc: layout-switcher - select/deselect items 
  author: DA
*/
jQuery(document).ready(function($) {

  var LayoutSwitcher = {

    config : {
      $main             : $("#main"),
      $layoutWrapper    : $(".filter-layout"),
      $layoutToChange   : $(".mod-photos > .photos-wrapper"),
      
      layoutToggles     : ".layout-type",
      selectClass       : "selected",

    },

    init : function(){
      //console.log('init');
      
      //console.log(this.config.$main);
      //console.log(this.config.$photos);
      //console.log(this.config.$photoItems);
      var that = this;

      that.config.$main.on('click', that.config.layoutToggles, function(evt){
        evt.preventDefault();
        that.toggleLayout(this);
        that.toggleClass(this);
      });

    },

    toggleLayout : function(el){

      var that = this,
          $layout = $(el);

      that.config.$layoutToChange.attr('data-layout', $layout.attr('data-layout') )
      //console.log($layout.attr('data-layout'), this);

    },

    toggleClass : function(el){
      console.log(el);

      var that = this,
          $el = $(el);

      $(that.config.layoutToggles).removeClass( that.config.selectClass );
      $el.addClass( that.config.selectClass );
      //that.config.$layoutToChange.attr('data-layout', $layout.attr('data-layout') )
    }     

  }// LayoutSwitcher

  LayoutSwitcher.init();

});// Ready

