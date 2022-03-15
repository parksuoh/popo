const mongoose = require('mongoose')
const moment = require("moment");
const { User } = require("./User");
const { ChatRoom } = require("./ChatRoom");

const chatSchema = mongoose.Schema({

    chatroomId: {
        type:String
    },
    userId: {
        type: String,
    },
    email: {
        type: String,
    },
    nickname: {
        type: String,
    },
    image: {
        type: String,
    },
    text: {
        type: String
    },
    created_at: { 
        type: Date,
        default: Date.now 
    },

})

const Chat = mongoose.model('Chat', chatSchema)

module.exports = {Chat}