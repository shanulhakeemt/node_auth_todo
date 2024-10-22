const express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");


authRouter.post("/auth/signup", async(req, res) => {

    try {

        const { name, email, password } = req.body;
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "User with same email already exist" });
        }
        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new User({ email: email, password: hashedPassword, name: name });
        user = await user.save();
        res.json(user);

    } catch (e) {
        res.status(500).json({ error: e.message });
    }

});


authRouter.post("/auth/login", async(req, res) => {
    try {
        const { name, email, password } = req.body;
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: "User with this email does not exist" });
        }
        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect Password" });
        }
        const token = jwt.sign({ id: user._id }, "passwordKey");

        res.json({ token, ...user._doc });
    } catch (e) {
        return res.status(500).json({ error: e.message });

    }



});
//get user data

authRouter.get("/auth", auth, async(req, res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token });

});

module.exports = authRouter;