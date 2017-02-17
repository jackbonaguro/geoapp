var express = require('express');
var mongoose = require('mongoose');

var user = require('./user.js');

var router = express.Router();


router.use(function(req, res, next) {
    var toke = req.headers.authorization;
    
    user.find({token: {$exists: true, $eq: toke}}, function(err, users) {
        if(err) console.error(err);

        if(users.length != 0) {
            console.log(users[0]);
            //The token was valid for user users[0]

            //IMPORTANT! - this is how all subsequent routes will access the user
            res.locals.authorizedUser = users[0];
            next();
        } else {
            //The token was invalid
            console.error("The token was invalid");
            res.status(500).send("The token was invalid");
        }
    });
});

router.post('/test', function(req, res) {
    var msg = "Hello "+res.locals.authorizedUser.username+"!";
    console.log(msg);

    res.json({posts: [{text: msg}]});
});

module.exports = router;
