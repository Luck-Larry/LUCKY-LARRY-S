const router = require('express').Router();
const { slots } = require('./controllers/slots');
const { getUser } = require('../database/controllers');

router.put('/slots', slots);

router.get('/test', (req, res) => {
  res.status(200).send('hello!');
});

router.get('/user', (req, res) => {
  getUser()
    .then((results) => res.send(results))
    .catch((err) => res.sendStatus(404));
});

module.exports = router;
