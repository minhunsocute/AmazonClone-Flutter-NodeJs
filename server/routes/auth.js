const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcryptjs");
const authRouter = express.Router();

authRouter.get('/user', (req, res) => {
    res.json({ msg: "Hung" });
});

//Sign Up
authRouter.post('/api/signup', async(req, res) => {
    try {
        const { name, email, password } = req.body;
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res
                .status(400)
                .json({ msg: "User with same email already exists!" });
        }
        const hasedPassword = await bcrypt.hash(password, 8);
        let user = new User({
            email,
            password: hasedPassword,
            name,
        });
        user = await user.save();
        res.json(user);
    } catch (err) {
        res.status(500).json({ err: err.message });
    }
    // _v 
    // id
    // get data from client
    // week-password - 6 characters, same-account-with-email
    // post that data in database
});

module.exports = authRouter;