const router = require('express').Router();
const slots = require('./controllers/slots');
const { addFriend, getAllFriends }= require('./controllers/friends');
const { getUser } = require('../database/controllers');

router.get('/slots', slots.spin);
router.get('/weightedSlots', slots.weightedSpin);

router.get('/users/:userID/friends', getAllFriends);

router.post('/users/:userID/friends', addFriend);

router.get('/test', (req, res) => {
  res.status(200).send('hello!');
});

router.get('/user', (req, res) => {
  getUser()
    .then((results) => res.send(results))
    .catch((err) => res.sendStatus(404));
});

module.exports = router;
