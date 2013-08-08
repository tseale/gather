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
    }
});

//given a phone number and password, return the user_id in the users collection
exports.findUserID = function(req, res) {
    var user_phone = req.body.phone_number;
    var user_pass = req.body.password;

	//first check if user_phone & user_pass combination is in database
    db.collection('users', function(err, user_collection) {
		user_collection.findOne({'phone_number': user_phone, 'password':user_pass}, function(err, user_obj) {
			if(err) {
				res.send({'error':'An error has occurred - ' + err});
			}	
			else { //user verification success, so open connection to events collection
				if(user_obj) {
					res.send(user_obj);
				}
				else {
					res.send({'error':'no user or invalid password'});
				}
			}
		});
    });
};
