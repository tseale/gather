var express = require('express'),
		app = express(),
		events = require('./routes/events');

app.configure(function () {
	app.use(express.bodyParser());
	app.use(express.logger('dev'));
});

//REST routes
app.get('/events', events.findAll);
app.get('/events/:id', events.findById);
app.post('/events', events.addEvent);
app.put('/events/:id', events.updateEvent);
app.del('/events/:id', events.deleteEvent);

var port = 8002;
app.listen(port);
console.log('Listening on port ' +port);
