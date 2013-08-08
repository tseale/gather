var mongo = require('mongodb');

var Server = mongo.Server,
	Db = mongo.Db,
	BSON = mongo.BSONPure;

var server = new Server('localhost', 27017, {auto_reconnect: true});
db = new Db('gather', server);
 
db.open(function(err, db) {
	if(!err) {
        console.log("Connected to 'gather' database");
        db.collection('users', {strict:true}, function(err, collection) {
			//do something on error (the collection didn't exist
        });
        db.collection('events', {strict:true}, function(err, collection) {
			//do something on error (the collection didn't exist
		});
    }
});

//given a user_id, the verification info (password), return all events for that user
exports.getUserEvents = function(req, res) {
    var user_id = req.body._id;
    var user_pass = req.body.password;

	//first check that the user verification info (password) was correct
    db.collection('users', function(err, user_collection) {
		user_collection.findOne({'_id':new BSON.ObjectID(user_id), 'password':user_pass}, function(err, user_obj) {
			if(err) {
				res.send({'error':'An error has occurred - ' + err});
			}	
			else { //user verification success, so open connection to events collection
				if(user_obj) {
					var event_ids = user_obj.events;

					db.collection('events', function(err, events_collection) {
						var userEvents = [];
						var counter = 0; //keeps track of how many events have been found and added to userEvents so far

						//first translate the contents of event_ids, doesn't work otherwise
						for(var i=0; i<event_ids.length; i++) {
							event_ids[i] = BSON.ObjectID(event_ids[i]);
						}
						
						//now try to find all events for the user and return
						events_collection.find({'_id': { $in: event_ids }}).toArray(function(err, event_obj) {
							res.send(event_obj);
						});
					});
				}
				else {
					res.send({'error':'no user or invalid password'});
				}
			}
		});
    });
};
