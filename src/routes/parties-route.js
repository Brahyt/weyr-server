const express = require('express');
const partiesRoute  = express.Router();
const jsonParse = express.json();
const PartiesService = require('../services/parties-service');
const {requireAuth} = require('../middleware/basic-auth');

partiesRoute
  .route('/')
  .all(requireAuth)
  .get((req, res, next) => {
    PartiesService
      .getAllParties(
        req.app.get('db'), 
        req.user.user_id
    )
      .then(result => {
        return res.json(PartiesService.serializeAllPartyReturn(result));
      })
      .catch(next)
  })
  .post(jsonParse, (req, res, next) => {
    const newParty = {
      ...req.body,
      user_id: req.user.user_id
    }
    PartiesService
      .createNewParty(req.app.get('db'), newParty)
      .then(result => {
        return res.json(PartiesService.serializePartyReturn(result));
      })
      .catch(next)
  });

partiesRoute
  .route('/:party_id')
  .all(requireAuth)
  .get((req, res, next) => {
    PartiesService.getPartyById(
      req.app.get('db'), 
      req.params.party_id, 
      req.user.user_id
    )
      .then(result => {
        if(result.length === 0) {
          return res.status(404).json({error:  "No party with that id"});
        } else {
          return res.json(PartiesService.serializeParty(result));
        }
      })
      .catch(next);
  })
  .delete((req, res, next) => {
    PartiesService
      .deletePartyById(
        req.app.get('db'), 
        req.params.party_id, 
        req.user.user_id
      )
      .then(() => {
        return res.json({"message": "party delteted"});
      })
      .catch(next)
  });


module.exports = partiesRoute;
