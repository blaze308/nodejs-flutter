const mongoose = require("mongoose")

const adminSchema = mongoose.Schema({
    username: {
        required: true,
        type: String,
        trim: true
    },

    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re =
                    /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                    value.match();
                    return value.match(re);
            },
            message: "Please enter a valid email address"
        }
    },
    password: {
        required: true,
        type: String,
        validate: {
            validator: (value) => {
                return value.length > 6;
            },
            message: "Please enter a long password"
        }
    },
    address: {
        type: String,
        default: "",
    },
    type: {
        type: String,
        default: "admin",
    },
    // cart: [
    //   {  product: productSchema }
    // ]
})

const Admin = mongoose.model("Admin", adminSchema);
module.exports = Admin;