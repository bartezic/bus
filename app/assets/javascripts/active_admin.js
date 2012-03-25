//= require active_admin/base
//= require jquery
//= require jquery_ujs

function remove_fields(link, association) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest("." + association + "_fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}