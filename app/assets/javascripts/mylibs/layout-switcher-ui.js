/*
  desc: layout-switcher - select/deselect items 
  author: DA
*/
jQuery(document).ready(function($) {

  var LayoutSwitcher = {

    config : {
      $main             : $("#main"),
      $layoutWrapper    : $(".filter-layout"),
      //$layoutToChange   : $(".mod-photos > .photos-wrapper"),
      $layoutToChange   : $(".photo-view"),
      
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


      // DA:TODO - Clean up - this is not good enough
      if ( $layout.attr('data-layout') === "map" ) {
      
        $('ul.photos-viewer').hide();
        $('.page-controls').hide();
        $('.map-view').show();
        
        Gmaps.loadMaps();
    
      }

      else{

        $('ul.photos-viewer').show();
        $('.page-controls').show();
        $('.map-view').hide();

        that.config.$layoutToChange.attr('data-layout', $layout.attr('data-layout') )
        console.log($layout.attr('data-layout'), this);
      }


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