const AuthService = require('../services/auth-service');

function requireAuth(req, res, next) {
  let bearerToken;
  const authToken = req.get('Authorization') || '';
  if (!authToken.toLowerCase().startsWith('bearer ')){
    return res.status(401).json({error: "Missing auth token"})
  }
  else {
    bearerToken = authToken.slice(7, authToken.length)
  }
  try {
    const payload = AuthService.verifyJwt(bearerToken)
    AuthService.getUserWithUserName(req.app.get('db'), payload.sub)
      .then(user => {
        if(!user) return res
          .status(401)
          .json({ error: "Unauthorized request" })
        req.user = user
        next()
        return null
      })
      .catch(err => {
        next(err)
      })
  } catch(error){
    res.status(401).json({error: 'Unauthorized request'})
  }
}



module.exports = {requireAuth};
