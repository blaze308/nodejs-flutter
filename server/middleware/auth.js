const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
    try {
        const token = req.header("tokenKey");

        if(!token) return res.status(401).json({msg: "you are not logged in"});
        const verified = jwt.verify(token, "passwordKey")
        if(!verified) return res.status(401).json({msg: "authorization failed"});

        req.user = verified.id;
        req.token = token;
        next();
    } catch (error) {
        res.status(500).json({error: error.message})
    }
}


module.exports = auth;