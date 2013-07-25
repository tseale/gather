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

						for(var i=0; i<event_ids.length; i++) {  //for all events in the user's "event array", find corresponding event in events_collection
							events_collection.findOne({'_id':new BSON.ObjectID(event_ids[i])}, function (err, event_obj) {
								userEvents.push(event_obj); //add the item to an array to be returned at end
								counter++;

								//this is necessary to wait till we finish finding all the events and then return everything...
								//seems kinda janky though... and possibly dangerous?
								if(counter==event_ids.length) {
									res.send(userEvents);
								}
							});
						}
					});
				}
				else {
					res.send('ERROR: no user');
				}
			}
		});
    });
};
