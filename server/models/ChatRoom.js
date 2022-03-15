const mongoose = require('mongoose')
const moment = require("moment");
const { User } = require("./User");
const { Chat } = require('./Chat');

const chatRoomSchema = mongoose.Schema({

    usersId: {
        type: Array
    },
    users: {
        type: Array,
    },
    chat: {
        type: Array,
    },
    created_at: { 
        type: Date, 
        default: Date.now 
    },
    updated_at: { 
        type: Date, 
        default: Date.now 
    },

})

const ChatRoom = mongoose.model('ChatRoom', chatRoomSchema)

module.exports = {ChatRoom}