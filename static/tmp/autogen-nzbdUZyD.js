
function deleteBlog(blogUrl){
 jquery.ajax(
  url : blogUrl,
  type: "DELETE",
  success: function(html){
    alert("ok, deleted");
    location.reload();
   }
 )
}
