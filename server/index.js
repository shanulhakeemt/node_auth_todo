const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const PORT = 3000;
const DB = "mongodb+srv://shanulhakeem60:Aj2gFWtLzoLwCQCH@cluster0.csbcw.mongodb.net/";
mongoose.connect(DB).then(() => {
    console.log('Connection Successfull');

}).catch((e) => {
    console.log('Error connecting to the database:', e);
});

const app = express();

app.use(express.json());
app.use(authRouter);
app.listen(PORT, "0.0.0.0", () => {
    console.log('Server started at ' + PORT);
});