const router = require('express').Router();
const { slots } = require('./controllers/slots');
const {
  getUser, getLeaderboard, getCountry, getGlobalChat, postGlobalChat,
} = require('../database/controllers');

router.put('/slots', slots);

router.get('/test', (req, res) => {
  res.status(200).send('hello!');
});

router.get('/user', (req, res) => {
  getUser()
    .then((results) => res.send(results))
    .catch(() => res.sendStatus(404));
});

router.get('/leaderboard', (req, res) => {
  getLeaderboard()
    .then((results) => res.send(results))
    .catch(() => res.sendStatus(404));
});

router.get('/country/:countryid', (req, res) => {
  getCountry(req.params.countryid)
    .then((results) => res.send(results))
    .catch(() => res.sendStatus(404));
});

router.get('/globalchat', (req, res) => {
  getGlobalChat(req.query.loginTime)
    .then((results) => res.send(results))
    .catch(() => res.sendStatus(404));
});

router.post('/globalchat', (req, res) => {
  const { username, message, country } = req.body;
  postGlobalChat(username, message, country).then((results) => res.send(results))
  .catch(() => res.sendStatus(404));
});

module.exports = router;
