const express = require('express');
const stickersRoute  = express.Router();
const StickersService = require('../services/stickers-service');
stickersRoute
  .route('/')
  .get((req, res, next) => {
    StickersService.getAllStickers(req.app.get('db'))
      .then(result => {
        res.json(result).status(200)
      })
      .catch(next)
  })
module.exports = stickersRoute;
