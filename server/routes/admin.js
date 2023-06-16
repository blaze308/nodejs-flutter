const express = require("express");
const {Product} = require("../models/product")
const admin = require("../middleware/admin")
const adminRouter = express.Router();



//add product
adminRouter.post("/api/admin/addproduct", admin, async (req, res) => {
    try {
        const {title, desc, image, price, category} = req.body;
        let product = new Product({
            title,
            image,
            desc,
            price,
            category,
        })

        product = await product.save();
        res.json(product)
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})


      

module.exports = adminRouter;
