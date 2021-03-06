var express = require('express'),
		app = express(),
		events = require('./routes/events'),
		users = require('./routes/users'),
		getevents = require('./routes/getevents'),
		response = require('./routes/response'),
		login = require('./routes/login');

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

app.get('/users', users.findAll);
app.get('/users/:id', users.findById);
app.post('/users', users.addUser);
app.put('/users/:id', users.updateUser);
app.del('/users/:id', users.deleteUser);

app.post('/getevents', getevents.getUserEvents);

app.post('/response', response.respondToEvent);

app.post('/login', login.findUserID);

var port = 8002;
app.listen(port);
console.log('Listening on port ' +port);
