var mongoose = require('mongoose');

var userschema = mongoose.Schema({
	username: String,
	hash: String,
    token: {}
});

var user = mongoose.model('user', userschema);

module.exports = user;
