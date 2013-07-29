$(document).ready( function() {

	$.getJSON( "objects.json", function(data) {
		$.each(data, function(method_i, method) { //for each method 
	
			var title = method["object_title"]; 
			//populate the method_table
			var html = 
			'<div class="table_button" id="'+title+'">'+
			title +
			'</div>';

			$("#method_table").append(html); //add the actual html element
			$("#"+title).click( function() { //tie in the click to the loadInfo function
				loadObject(title);
			}); 
		});
		$("#method_table").append("<hr>");
	});

	$.getJSON( "api.json", function(data) {
		$.each(data, function(method_i, method) { //for each method 
	
			var url = method["method_url"].slice(1); //slice to take off "/"
			//populate the method_table
			var html = 
			'<div class="table_button" id="'+url+'">'+
			"/"+url +
			'</div>';

			$("#method_table").append(html); //add the actual html element
			$("#"+url).click( function() { //tie in the click to the loadInfo function
				loadMethod(url);
			}); 
		});
	});
});

//called when a specific object is selected, populate the main method_description div with info
function loadObject(title) {

	//TODO change to select all class="table_button"
	//set all background colors back to normal
	$("#method_table").children().css("backgroundColor", "#eee");

	//darken the current selector in the table
	var tar_str = "#"+title;
	var tar_div = $(tar_str);
	tar_div.css( "backgroundColor", "#ccc");

	$.getJSON( "objects.json", function(data) {
		$.each(data, function(object_i, object) { //for each object, find the correct one 
			if(object["object_title"]==title) {
				$("#method_description").empty();

				var html = 
				'<h2>'+object["object_title"]+'</h2>'+
				'<h3>'+object["object_desc"]+'</h3>';

				$.each(object["examples"], function(ex_i, ex) {
					html +=  JSON.stringify(ex, null, '\t');
				});

				$("#method_description").append(html);
			}
		});
	});
}

//called when a specific method is selected, populate the main method_description div with info
function loadMethod(url) {

	//set all background colors back to normal
	$("#method_table").children().css("backgroundColor", "#eee");

	//darken the current selector in the table
	var tar_str = "#"+url;
	var tar_div = $(tar_str);
	tar_div.css( "backgroundColor", "#ccc");

	$.getJSON( "api.json", function(data) {
		$.each(data, function(method_i, method) { //for each method, find the correct one 
			if(method["method_url"].slice(1)==url) {
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
