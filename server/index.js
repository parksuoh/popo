const express = require('express')
const app = express()

const server = require('http').createServer(app)
const io = require('socket.io')(server) 


const cors = require('cors')
const PORT = 3000

const bodyParser = require('body-parser')
const cookieParser = require('cookie-parser')


const config = require('./config/key')

app.use(bodyParser.urlencoded({extended: true})) // application/x-www-form-urlencoded


const mongoose = require('mongoose')
const { Chat } = require('./models/Chat')

mongoose.connect(config.mongoURI,
    {useNewUrlParser: true, useUnifiedTopology: true})
.then(()=> console.log('몽고db 연결됨'))
.catch(err => console.log(err))

app.use(cors())

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json()) // application/json
app.use(cookieParser())


app.use('/api/user', require('./route/user'));
app.use('/api/chat', require('./route/chat'));
app.use('/api/chatroom', require('./route/chatroom'));


io.on('connection', (socket) => {

    console.log('소켓 연결됨')

    socket.on('message', (msgData) => {
        console.log('메세지:' + msgData)
        let jsonMsgData = JSON.parse(msgData)

        const chat = new Chat({
            chatroomId: jsonMsgData.chatRoomId,
            userId: jsonMsgData.userId,
            email: jsonMsgData.email,
            nickname: jsonMsgData.nickname,
            image: jsonMsgData.image,
            text: jsonMsgData.text,
        })

        chat.save((err, item) => {
            if(err) console.log(err)
            console.log('성공')
        })
        
        socket.broadcast.to(jsonMsgData.chatRoomId).emit("receive-message", msgData)
        
    })

    socket.on('join-room', chatRoomId => {
        console.log('룸에 들어옴')
        socket.join(chatRoomId)
    })

    socket.on('leave-room', chatRoomId => {
        console.log('룸에서 나감')
        socket.leave(chatRoomId)
    })

    socket.on('disconnect', () => {
        console.log('disconnect')
    })


})




server.listen(PORT, () => console.log(`연결됨 ${PORT}`))

//몽고db 유저내임 비번 suohtest 01076570163