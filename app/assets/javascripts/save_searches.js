$(function () {
  //$('.edit_task input[type=submit]').remove();
  $('#new_save_search .cancel').click(function () {
    alert("hi");
    return false;
  }); 
	$('#new_save_search').live('submit', function () {
	    
	    $('#save_search_params').val($('#search_form').serialize()); 

	    
	  }); 

});