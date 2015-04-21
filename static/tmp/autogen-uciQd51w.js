
function putBlogPost (){
    $.ajax({
        url: "/json/Blog/new",
	type: "PUT",
	data: '{"article":{"markdown":"Sebastian"},"uid":2,"title":"Hola Mundo"}',
	success: function(data){
	 alert(data);
	},
	error: function(xhr,status,error){
	    alert(xhr.responseText);
	},
	dataType="Json"
    });

}
