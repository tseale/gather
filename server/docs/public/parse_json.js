$(document).ready( function() {

	$.getJSON( "api.json", function(data) {
		$.each(data, function(method_i, method) { //for each method 

			//populate the method_table
			$("#method_table").append('<p>'+method["method_title"]+'</p>');
			
			var html = 
			'<h1>'+method["method_title"]+'</h1>'+
			'<h2>'+method["method_url"]+'</h2>'+
			'<h3>'+method["method_desc"]+'</h3>';
				
			$.each(method["functions"], function(func_i, func) {
				html += 
				'<h4>'+func["func_title"]+'</h4>'+
				'<p>'+func["func_desc"]+'</p>';
			});

			$("#method_description").append(html);
		});
	});
});
