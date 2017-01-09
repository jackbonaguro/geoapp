var express = require('express');
var bodyParser = require('body-parser');
var mysql = require('mysql');

var app = express();
app.use(bodyParser.urlencoded());
app.use(bodyParser.json());

var con = mysql.createConnection({
	host: 'localhost',
	user: 'root',
	password: '',
	database: 'geoapp'
});
con.connect(function(err) {
	if (err) {
    	console.log('Error connecting to SQL database');
	} else {
    	console.log('Successfully connected to SQL database...');
	}
});

//Utility Functions
var location_to_block = function(lat,lon) {
	blat = Math.floor(lat*10);
	blon = Math.floor(lon*10);
	return {blat, blon};
}

app.get('/posts', function(req, res) {
	console.log(req.body);
	var location = req.body.location;
	console.log(location);
	var block = location_to_block(location['lat'], location['lon']);
	console.log(block);
	var query = 'select id, lat, lon, timestamp, text from posts where block_lat='+block.blat
		+' AND block_lon='+block.blon+';';
	con.query(query, function(err, result) {
		if (err) throw err;
		res.send(result);
	});
});

app.get('/posts/:id/comments', function(req, res) {
	var id = req.params.id;
	var query = 'select commentid from post_comments where postid='+id+';';
	con.query(query, function(err, result) {
		if (err) throw err;
		if (result.length <= 0) {
			res.send([]);
		} else {
			var commentids = result.map(function(a) {return a.commentid});
			var query2 = 'select id, timestamp, text from comments where id in ('+
			commentids.join(',')+');';
			//console.log(query2)
			con.query(query2, function(err, result) {
				if (err) throw err;
				res.send(result);
			});
		}
	});
});

app.post('/newpost', function(req, res) {
	var text = req.body.text;
	var location = req.body.location;
	var block = location_to_block(location['lat'], location['lon']);
	//add post to db
	var query = 'insert into posts(lat, lon, block_lat, block_lon, timestamp,'
		+ ' text) values('+location.lat
		+', '+location.lon
		+', '+block.blat
		+', '+block.blon
		+', NOW(), "'+text+'");'
	con.query(query, function(err, result) {
		if (err) throw err;
		res.end();
	});
});

app.post('/posts/:id/newcomment', function(req, res) {
	var id = req.params.id;
	var text = req.body.text;
	//add comment to db
	var query = 'insert into comments(timestamp, text) values(NOW(), "'+text+'");'
	console.log(query);
	con.query(query, function(err, result) {
		if (err) throw err;
  		insertId = result.insertId;
  		//add relation from comment to post
		var query2 = 'insert into post_comments(postid, commentid) values('+id
			+', '+insertId+');';
		console.log(query2);
		con.query(query2, function(err, result) {
			if (err) throw err;
			res.end();
		});
	});
});

app.listen(3333);
console.log('Listening on port 3333...');