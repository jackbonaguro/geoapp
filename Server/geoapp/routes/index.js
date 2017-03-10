var express = require('express');
var router = express.Router();

var schema = require('../src/schema');
var user = schema.user;
var post = schema.post;

/* GET home page. */
router.post('/posts', function(req, res, next) {
    console.log('Nearby posts');
    //We use mongoose's built-in comparison operators
    // to find posts within 1 degree of the user
//    var ulat = req.body.latitude + 0.5;
    var llat = req.body.latitude - 0.5;
    var ulat = llat + 1;

//    var ulon = req.body.longitude + 0.5;
    var llon = req.body.longitude - 0.5;
    var ulon = llon + 1;

    console.log(ulat+", "+llat+", "+ulon+", "+llon);

    post.find({
            latitude: { '$gte': llat,
                        '$lte': ulat
                    },
            longitude: { '$gte': llon,
                         '$lte': ulon
            }
    },
    function(err, posts) {
        if(err) console.error(err);
        console.log(posts);
        res.json({nearby_posts: posts});
    });
});

module.exports = router;
