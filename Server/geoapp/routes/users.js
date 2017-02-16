var bcrypt = require("bcrypt");
var express = require('express');
var mongoose = require('mongoose');

var router = express.Router();

var userschema = mongoose.Schema({
	username: String,
	hash: String
});

var user = mongoose.model('user', userschema);

router.post('/create', function(req,res,err){
	console.log('Create user request');
	user.find({username: req.body.username}, function(err, users) {
		if(err) console.error(err);

		if(users.length == 0) {
			console.log("Username  is unique");
			bcrypt.genSalt(10, function(err, salt) {
				if(err) console.error(err);
				bcrypt.hash(req.body.password,
					salt,
					function(err, thehash) {

					console.log("Hash: " + thehash);
					user.create({username: req.body.username,
						hash: thehash},
						function(err, user) {
							if(err) console.error(err);
							console.log(user);
							res.end('User ' + req.body.username + " created");
						});
				});
			});
		} else {
			res.end();
		}
	});
});

module.exports = router;
