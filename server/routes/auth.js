const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcrypt")
const { Product } = require("../models/product")
const jwt = require("jsonwebtoken")

const authRouter = express.Router();



//get 
authRouter.get("/api/data", async (req, res) => {
    try {
        const products = await Product.find().sort({_id : -1});
        res.json(products)
    } catch (error) {
        res.status(500).json({error: "Error fetching products"})
    }
})

//get by category
authRouter.get("/api/data/category/:category", async (req, res) => {
    try {
        const products = await Product.find({category: req.params.category});
        res.json(products)
    } catch (error) {
        res.status(500).json({error: "Error fetching products"})
    }
})

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
        const {identifier, password} = req.body;

        // const user = await User.findOne({email})
        // const userwithName = await User.findOne({username})
        const user = await User.findOne({ $or: [{ email: identifier }, { username: identifier }] });
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