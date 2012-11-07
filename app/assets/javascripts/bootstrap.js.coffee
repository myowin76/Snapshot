jQuery ->
  ###$(".accordion").on "show hide", (e) ->
  $(e.target).siblings(".accordion-heading").find(".accordion-toggle i").toggleClass "icon-plus icon-minus"###
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  
