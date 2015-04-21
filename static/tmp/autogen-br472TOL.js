
function deleteBlog(blogUrl){
 alert("Delete URl"+ blogurl)
 jquery.ajax(
  url : blogUrl,
  type: "DELETE",
  success: function(html){
    alert("ok, deleted");
    location.reload();
   }
 )
}
