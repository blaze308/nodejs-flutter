const jwt = require("jsonwebtoken")

const admin = async (req, res, next) => {
    try {
        const token = req.header("passwordKey");

        const verified = jwt.verify(token, "passwordKey")
    } catch (error) {
        
    }
}