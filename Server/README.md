# Server

This backend handles user accounts/token-based sessions, amd storage/retrieval of real-world data.

### /posts

-> {latitude: 0, longitude: 0}

<- {posts: [
        { _id: ObjectId,
          latitude: 0,
          longitude: 0,
          altitude: 0,
          text: "ABC",
          creator: User,
          time: Time,
          comments: []
        }
]}

Returns a list of all posts within a rectangle of 1 degree latitude and 1 degree longitude.

## /user

Methods relating to accounts, sessions, etc.

### /user/create

-> {username: 'XXX', password: 'YYY'}

<- {text: "User XXX created"}

Creates a new user

### /user/login

-> {username: 'XXX', password: 'YYY'}

<- {token: [A randomly generated integer]}

Login the user and establish a token that can be used to authorize them for routes starting with /authorized

## /authorized

-> Headers.Authorization = [A valid token]

If the token is linked to a valid user, they are authorized to perform certain actions for that account

### /authorized/test

<- {text: 'Hello XXX!'}

To make sure their token is valid

### /authorized/newpost

-> {text: 'ABC', longitude: 0, latitude: 0, altitude: 0}

<- {text: 'Post created: ABC'}

Create a post
