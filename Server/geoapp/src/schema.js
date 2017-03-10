var mongoose = require('mongoose');

var userschema = mongoose.Schema({
	username: String,
	hash: String,
    token: {},
    posts: [{type: mongoose.Schema.Types.ObjectId, ref: 'Post'}],
    likes: [{type: mongoose.Schema.Types.ObjectId, ref: 'Post'}]
});

var postschema = mongoose.Schema({
    text: String,
    longitude: Number,
    latitude: Number,
    altitude: Number,
    comments: [{text: String, time: Date}],
    time: Date,
    creator: {type: mongoose.Schema.Types.ObjectId,
            ref: 'user'
            }
});

var user = mongoose.model('user', userschema);
var post = mongoose.model('post', postschema);

module.exports.user = user;
module.exports.post = post;
