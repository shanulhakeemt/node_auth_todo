const express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const authRouter = express.Router();

authRouter.post("/auth/signup", async(req, res) => {

    try {

        const { name, email, password } = req.body;
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "User with same email aleady exist" });
        }
        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new User({ email: email, password: hashedPassword, name: name });
        user = await user.save();
        res.json(user);

    } catch (e) {
        res.status(500).json({ error: e.message });
    }

});

module.exports = authRouter;