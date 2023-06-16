const express = require("express");
const adminRouter = express.Router();
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const Admin = require("../models/admin");



//signup admin
adminRouter.post("/admin/signup", async (req, res) => {
    try {
        const {username, email, password} = req.body;

        const existingAdmin = await Admin.findOne({email});
        if(existingAdmin) {
            res.status(400).json({msg: "admin with email already exists"})
        }
        
        const existingAdminName = await Admin.findOne({username});
        if(existingAdminName) {
            res.status(400).json({msg: "admin with username already exists"})
        }

        const hashedPassword = await bcrypt.hash(password, 8);

        let admin = new Admin({
            email,
            username,
            password: hashedPassword,
        })

        admin = await admin.save();
        res.json(admin);
    } catch (error) {
        
    }
})

//login admin
adminRouter.post("/admin/login", async (req, res) => {
    try {
        const {identifier, password} = req.body;

        const admin = await Admin.findOne({ $or: [{ email: identifier }, { username: identifier }] });
        if(!admin) {
            return res.status(400).json({msg: "Admin with this username or email does not exist"})
        }

        const isMatch = await bcrypt.compare(password, admin.password);

        if(!isMatch) {
            return res.status(400).json({msg: "Incorrect password"})
        }

        const adminToken = jwt.sign({id: admin._id}, "AdminPasswordKey")
        res.json({adminToken, ...admin._doc})
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})


module.exports = adminRouter;
