// http://jsfiddle.net/sxGtM/3/
$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

$(function () {
  //$('.edit_task input[type=submit]').remove();
  $('#new_save_search .cancel').click(function () {
    return false;
  });
	$('#new_save_search').live('submit', function () {
	    //$('#save_search_params').val($('#search_form').serializeArray()); 
	    //var values = ($('#search_form').serialize()); 
	    //values += "&content=" + encodeURIComponent(content_val);
	    //alert(values);
	    $('#save_search_params').val(JSON.stringify($('#search_form').serializeObject()));
        
	  });
});

// $(function () {
  
//     $('#save-search').live('click', function () {
//       var test = JSON.stringify($('#search_form').serializeObject());
//       alert(test);
//       });
// });

