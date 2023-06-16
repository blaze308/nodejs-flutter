const express = require('express')
const authRouter = require("./routes/auth")
const mongoose = require("mongoose")
const adminRouter = require('./routes/admin')
const userRouter = require('./routes/user')
const DB = "mongodb+srv://jay:jay@cluster0.cn1i7rd.mongodb.net/ecommdb?retryWrites=true&w=majority"

const app = express()
const port = 7000

//middleware
app.use(express.json())
app.use(authRouter);
app.use(adminRouter);
app.use(userRouter);


//connnections
mongoose.connect(DB).then(() => {
    console.log("Connection Successful");
}).catch((e) => {
    console.log(e);
})

app.listen(port, "0.0.0.0", () =>  {
    console.log(`connected at port ${port}`)
})