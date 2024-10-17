const express = require("express");
const authRouter = express.Router();

authRouter.post("auth/signup", async(req, res) => {

    try {

        const { name, email, password } = req.body;
        const existingUser = User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "User with same email aleady exist" });
        }
        const hashedPassword = bcryptjs.hash(password, 8);

        let user = new User({ email: email, password: hashedPassword, name: name });

    } catch (e) {}

});

module.exports = authRouter;