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
            if (err) {
                console.log("The 'events' collection doesn't exist. Creating an empty copy...");
								var event_empty = [{
										what : "Dinner",
										when : "6:30pm Wednesday",
										where : "Ian's",
										group : "Interns",
										who: [
											
										],
										suggestions : [


										]
								}];
								db.collection('events', function(err, collection) {
										collection.insert(event_empty, {safe:true}, function(err, result) {} );
								});
            }
        });
    }
});


exports.findById = function(req, res) {
    var id = req.params.id;
    console.log('Retrieving event: ' + id);
    db.collection('events', function(err, collection) {
        collection.findOne({'_id':new BSON.ObjectID(id)}, function(err, item) {
            res.send(item);
        });
    });
};

exports.findAll = function(req, res) {
    db.collection('events', function(err, collection) {
        collection.find().toArray(function(err, items) {
            res.send(items);
        });
    });
};

exports.addEvent = function(req, res) {
    var curr_event = req.body;
    console.log('Adding event: ' + JSON.stringify(curr_event));
    db.collection('events', function(err, collection) {
        collection.insert(curr_event, {safe:true}, function(err, result) {
            if (err) {
                res.send({'error':'An error has occurred'});
            } else {
                console.log('Success: ' + JSON.stringify(result[0]));
                res.send(result[0]);
            }
        });
    });
};
 
exports.updateEvent = function(req, res) {
    var id = req.params.id;
    var curr_event = req.body;
    console.log('Updating event: ' + id);
    console.log(JSON.stringify(curr_event));
    db.collection('events', function(err, collection) {
        collection.update({'_id':new BSON.ObjectID(id)}, curr_event, {safe:true}, function(err, result) {
            if (err) {
                console.log('Error updating event: ' + err);
                res.send({'error':'An error has occurred'});
            } else {
                console.log('' + result + ' document(s) updated');
                res.send(curr_event);
            }
        });
    });
};
 
exports.deleteEvent = function(req, res) {
    var id = req.params.id;
    console.log('Deleting event: ' + id);
    db.collection('events', function(err, collection) {
        collection.remove({'_id':new BSON.ObjectID(id)}, {safe:true}, function(err, result) {
            if (err) {
                res.send({'error':'An error has occurred - ' + err});
            } else {
                console.log('' + result + ' document(s) deleted');
                res.send(req.body);
            }
        });
    });
};
