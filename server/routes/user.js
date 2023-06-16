const express = require("express");
const auth = require("../middleware/auth");
const { Product } = require("../models/product");
const User = require("../models/user");
const userRouter = express.Router();

userRouter.post("/api/addtocart", auth, async (req, res) => {
    try {
        const {id} = req.body;
        const product = await Product.findById(id);

        let user = await User.findById(req.user);
        if(user.cart.length == 0) {
            user.cart.push({product, quantity: 1});
        }
        else {
            let isProductFound = false;
            for(let i = 0; i < user.cart.length; i++){
                if(user.cart[i].product_.id.equals(product._id)){
                    isProductFound = true;
                }
            }
            if(isProductFound) {
                let productFound = user.cart.find((productt) => productt.product._id.equals(product._id));
                productFound.quantity += 1;
            }
            else {
                user.cart.push({product, quantity: 1});
            }
        }
        user = await user.save();
        res.json(user);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})

module.exports = userRouter;