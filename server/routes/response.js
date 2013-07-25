var mongo = require('mongodb');

var Server = mongo.Server,
	Db = mongo.Db,
	BSON = mongo.BSONPure;

var server = new Server('localhost', 27017, {auto_reconnect: true});
db = new Db('gather', server);
 
db.open(function(err, db) {
	if(!err) {
        console.log("Connected to 'gather' database");
        db.collection('events', {strict:true}, function(err, collection) {
			//do something on error (the collection didn't exist
		});
    }
});

//given a user_id, the verification info (password), return all events for that user
exports.respondToEvent = function(req, res) {
    var event_id = req.body._id;
    var user_id = req.body.user_id;
	var response = req.body.response;

	db.collection('events', function(err, events_collection) {
		//find the correct even
		events_collection.findOne({'_id':new BSON.ObjectID(event_id)}, function (err, event_obj) {

			//find the correct participant and update the reponse
			var participants = event_obj.who;	
			for(var i=0; i<participants.length; i++) {
				if(participants[i].user_id==user_id) {
					participants[i].response = response;
				}
			}

			//now update the database
			events_collection.update({'_id':new BSON.ObjectID(event_id)}, event_obj, {safe:true}, function(err, result) {
				if (err) {
					res.send({'error':'An error has occurred'});
				} else {
					console.log('' + result + ' document(s) updated');
					res.send(result[0]);
				}
			});

		});
	});
};
