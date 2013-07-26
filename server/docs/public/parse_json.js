$(document).ready( function() {

	$.getJSON( "api.json", function(data) {
		$.each(data, function(method_i, method) { //for each method 
			//populate the method_table
			var html = 
			'<a href="#"  onclick="loadInfo('+"'"+method["method_title"]+"'"+');return false;"><div id="'+method["method_title"]+'">'+
			method["method_title"]+
			'</div></a>';

			$("#method_table").append(html);
		});
	});
});

//called when a specific method is selected, populate the main method_description div with info
function loadInfo(method_title) {
	
	//darken the current selector in the table
	var tar_str = "#"+method_title;
	var tar_div = $(tar_str);
	tar_div.css( "backgroundColor", "#ccc");
	/*
	console.log(tar_div);
	tar_div.animate({
		backgroundColor: "5px"

	}, 1000, function() {});
	*/

	$.getJSON( "api.json", function(data) {
		$.each(data, function(method_i, method) { //for each method, find the correct one 
			if(method["method_title"]==method_title) {
				$("#method_description").empty();

				var html = 
				'<h2>'+method["method_url"]+'</h2>'+
				'<h3>'+method["method_desc"]+'</h3>';
					
				$.each(method["functions"], function(func_i, func) {
					html += 
					'<hr><h4>'+func["func_title"]+'</h4>'+
					'<p>'+func["func_desc"]+'</p>';
					if(func["params"]) {
						html+='<p><h5>params: </h5>'+func["params"]+'</p>';
					}
					if(func["returns"]) {
						html+='<p><h6>returns: </h6>'+func["returns"]+'</p>';
					}
				});

				$("#method_description").append(html);
			}
		});
	});
}
