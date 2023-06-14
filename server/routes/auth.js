const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcrypt")
const jwt = require("jsonwebtoken")

const authRouter = express.Router();


//signup
authRouter.post("/api/signup", async (req, res) => {
   try {
    const {username, email, password} = req.body;

    const existingUser = await User.findOne({email})
    if (existingUser) {
        return res.status(400).json({msg : "user with same email already exists"})
    }
    
    const existingUserName = await User.findOne({username})
    if (existingUserName) {
        return res.status(400).json({msg : "user with same username already exists"})
    }

    const hashedPassword = await bcrypt.hash(password, 8)

    let user = new User({
         email,
         username,
         password: hashedPassword,
    })

    user = await user.save();
    res.json(user);
   } catch (error) {
        res.status(500).json({error: error.message})
   }

});

//login route
authRouter.post("/api/login", async (req, res) => {
    try {
        const {username, email, password} = req.body;

        // const user = await User.findOne({email})
        // const userwithName = await User.findOne({username})
        const user = await User.findOne({ $or: [{ email }, { username }] });
        if(!user) {
            return res.status(400).json({msg: "User with this username or email does not exist"})
        }

        // if(!userwithName) {
        //     return res.status(400).json({msg: "User with this username does not exist"})
        // }

        const isMatch = await bcrypt.compare(password, user.password);

        if(!isMatch) {
            return res.status(400).json({msg: "Incorrect password"})
        }

        const token = jwt.sign({id: user._id}, "passwordKey")
        res.json({token, ...user._doc})
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})

module.exports = authRouter;