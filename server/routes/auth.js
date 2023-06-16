const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcrypt")
const { Product } = require("../models/product")
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");

const authRouter = express.Router();



//get all products 
authRouter.get("/api/data", async (req, res) => {
    try {
        //reverse sort
        const products = await Product.find().sort({_id : -1});
        res.json(products)
    } catch (error) {
        res.status(500).json({error: "Error fetching products"})
    }
})

//get products by category
authRouter.get("/api/data/category/:category", async (req, res) => {
    try {
        const products = await Product.find({category: req.params.category});
        res.json(products)
    } catch (error) {
        res.status(500).json({error: "Error fetching products"})
    }
})


//signup user
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

//login user
authRouter.post("/api/login", async (req, res) => {
    try {
        const {identifier, password} = req.body;

        // const user = await User.findOne({email})
        // const userwithName = await User.findOne({username})
        const user = await User.findOne({ $or: [{ email: identifier }, { username: identifier }] });
        if(!user) {
            return res.status(400).json({msg: "User with this username or email does not exist"})
        }

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

//change user type to admin
// authRouter.post("/api/admin/signup", async (req, res) => {
//     try {
//      const {username, email, password } = req.body;
 
//      const existingUser = await User.findOne({ $or: [{ email: email }, { username: username }] });
//      if(existingUser) {
//         let user = await User.findOneAndUpdate({id: existingUser._id}, { $or: [{ email: email }, { username: username }] })
        
//         const isMatch = bcrypt.compare(password, user.password)


//         if(!isMatch){
//             return res.status(400).json({msg: "Incorrect password"})
//         }

//         user = new User({
//               email,
//               username,
//               type: "admin",
//               password: hashedPassword,
//             })
            
//             user = await user.save();
//             res.json(user);
//         }

//         else {
//             res.status(400).json({msg: "no user found"})
//         }
 
//     } catch (error) {
//          res.status(500).json({error: error.message})
//     }
 
//  });
 
//signup admin
authRouter.post("/api/admin/signup", async (req, res) => {
    try {
     const {username, email, password } = req.body;
 
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
          type: "admin",
          password: hashedPassword,
     })
 
     user = await user.save();
     res.json(user);
    } catch (error) {
         res.status(500).json({error: error.message})
    }
 
 });
 


//token validator
authRouter.post("/api/tokenvalidate", async (req, res) => {
    try {
        const token = req.header("tokenKey");
        if(!token) return res.json(false)

        const verified = jwt.verify(token, "passwordKey")
        if(!verified) return res.json(false)

        const user = await User.findById(verified.id);
        if(!user)  return res.json(false)
        res.json(true);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})


//get user data
authRouter.get("/api/account", auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token});
})



module.exports = authRouter;