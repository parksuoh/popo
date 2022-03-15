const express = require('express');
const router = express.Router();
const ObjectId = require('mongoose').Types.ObjectId;
const { ChatRoom } = require("../models/ChatRoom");
const { User } = require('../models/User');


router.get('/gochatroom', async (req, res) => {

    // 유저아이디를 가지고 유저 객체 뽑기

    let myId = req.query.myId
    let friendId = req.query.friendId

    let myUser = await User.findById(myId)
    let friendUser = await User.findById(friendId)


    ChatRoom.findOne({ usersId : { $in : [myId, friendId]} }, (err, chatRoom) => {


        if(!chatRoom) {
        
            // 새로운 유저 만들때 유저 객체를 넣어주기
            const newChat = new ChatRoom({usersId: [myId, friendId], users: [myUser, friendUser]})

            newChat.save((err, NewChatRoom) => {
                if(err) return res.json({ success: false, err })
                console.log(NewChatRoom)
                return res.status(200).json({
                    Success: true,
                    ChatRoomId: NewChatRoom._id
                })          
            })

        } else {
            if(err) return res.json({ success: false, err })
            console.log(chatRoom)
            return res.status(200).json({
                Success: true,
                ChatRoomId: chatRoom._id
            })
        }

    })
    
})


router.get('/chatroomlist', (req, res) => {

    let myId = req.query.id

    // todo users객체안에서 myId찾기
    ChatRoom.find({usersId: { $in: [myId]}})
    .exec((err, data) => {
        if(err) return res.json({ success: false, err })
        return res.status(200).send(data);
    })


})


module.exports = router;