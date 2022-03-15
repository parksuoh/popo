const express = require('express');
const { Chat } = require('../models/Chat');
const router = express.Router();
const ObjectId = require('mongoose').Types.ObjectId;

router.get('/getchats', (req, res) => {

    let chatRoomId = req.query.chatRoomId;

    Chat.find({chatroomId : chatRoomId})
    .exec((err, data) => {
        if(err) return res.json({ success: false, err })
        return res.status(200).send(data);
    })


})



module.exports = router;