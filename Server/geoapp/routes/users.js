var bcrypt = require("bcrypt");
var express = require('express');
var mongoose = require('mongoose');

var router = express.Router();

var userSchema = mongoose.Schema({
	username: String,
	hash: String
});

var user = mongoose.model('user', userSchema);

router.post('/create', function(req, res, next) {
	user.find({username: req.ody.username}, function(err, users) {
		//If users is empty then the username was unique
		res.send(users);
		/*if (users == []) {
			console.log("Username was unique");
			bcrypt.saltGen(10, function(err, salt) {
				bcrypt.hash(req.body.password,
					salt,
					function(err, thehash) {

					console.log("Hash: " + thehash);
					user.create({username: req.body.username,
						hash: thehash},
						function(err, user) {
							console.log("User created");
							if(err) console.error(err);
							else console.log(user);
							res.end('User created');
					});
				});
			});
		}*/
	});
});

module.exports = router;
