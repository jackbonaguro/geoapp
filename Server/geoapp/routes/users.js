var bcrypt = require("bcrypt");
var express = require('express');
var mongoose = require('mongoose');
var randtoken = require('rand-token');

var user = require('./user.js');

var router = express.Router();


router.post('/create', function(req,res,err){
	//console.log('Create user request');
	user.find({username: req.body.username}, function(err, users) {
		if(err) console.error(err);

		if(users.length == 0) {
			//console.log("Username  is unique");
			bcrypt.genSalt(10, function(err, salt) {
				if(err) console.error(err);
				bcrypt.hash(req.body.password,
					salt,
					function(err, thehash) {

                    if(err) console.error(err);

					//console.log("Hash: " + thehash);
					user.create({username: req.body.username,
						hash: thehash, token: {}},
						function(err, user) {
							if(err) console.error(err);
							console.log(user);
							var msg = 'User ' + req.body.username + " created";
                            res.json({text: msg, username: req.body.username});
						});
				});
			});
		} else {
			res.status(500).send("Username is not unique");
		}
	});
});

router.post('/login', function(req, res, err) {
    user.find({username: req.body.username}, function(err, users) {
        if(users.length != 0) {
            //If user exists
            //console.log("Users: "+users);
            //console.log("Hash: "+users[0]['hash']);
            bcrypt.compare(req.body.password, users[0]['hash'],
                function(err,result){
                
                if(err) console.error(err);
                if(result) {
                    //Passwords match
                    var toke = randtoken.generate(16);
                    users[0].token = toke;
                    users[0].save();
                    res.json({authorization: toke});
                } else {
                    //Passwords do not match
                    res.status(500).send("Password is incorrect");
                }
            });
        } else {
            //User does not exist
            res.status(500).send("User does not exist");
        }
    });
});

module.exports = router;
