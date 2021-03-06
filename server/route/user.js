const express = require('express');
const router = express.Router();
const { User } = require("../models/User");
const ObjectId = require('mongoose').Types.ObjectId;

const { auth, appauth } = require("../middleware/auth");


router.get('/auth', auth, (req, res) => {

    // 여기까지 미들웨어를 통과해왔다는 얘기는  Auth 가  true
    res.status(200).json({

        _id: req.user._id,
        isAdmin: req.user.role === 0 ? false : true,
        isAuth: true,
        email: req.user.email,
        nickname: req.user.nickname,
        role: req.user.role,
        image: req.user.image

    })

})

router.get('/appauth', appauth, (req, res) => {

    // 여기까지 미들웨어를 통과해왔다는 얘기는  Auth 가  true
    res.status(200).json({

        _id: req.user._id,
        isAdmin: req.user.role === 0 ? false : true,
        isAuth: true,
        email: req.user.email,
        nickname: req.user.nickname,
        role: req.user.role,
        image: req.user.image

    })

})

router.post('/register', (req, res) => {

    const user = new User(req.body)
    
    user.save((err, userInfo) => {
        if(err) return res.json({ success: false, err})
        return res.status(200).json({
            success: true
        })
    })

})

router.post('/login', (req, res) => {

    // 요청된 이메일을 데이터베이스에서있는지 찾는다.
    User.findOne({ email: req.body.email }, (err, user) => {
        if(!user){
            return res.json({
                loginSuccess: false,
                message: "제공된 이메일에 해당하는 유저가 없습니다."
            })
        }

        // 요청된 이메일이 데이터 베이스에 잇다면 비밀번호가 맞는 비밀번호 인지 확인

        user.comparePassword(req.body.password, (err, isMatch) => {
            if(!isMatch)
            return res.json({loginSuccess: false, message: "비밀번호가 틀렸습니다."})

            // 비밀번호 까지 맞다면 토큰을 생성하기

            user.generateToken((err, user) => {
                if(err) return res.status(400).send(err);
                
                // 토큰을 저장한다. 어디에? 쿠키, 로컬스토리지
                    res.cookie("x_auth", user.token )
                    .status(200)
                    .json({ loginSuccess: true, userId: user._id })       
            })
        })
    })
})

router.post('/applogin', (req, res) => {

    // 요청된 이메일을 데이터베이스에서있는지 찾는다.
    User.findOne({ email: req.body.email }, (err, user) => {
        if(!user){
            return res.json({
                loginSuccess: false,
                message: "제공된 이메일에 해당하는 유저가 없습니다."
            })
        }

        // 요청된 이메일이 데이터 베이스에 잇다면 비밀번호가 맞는 비밀번호 인지 확인

        user.comparePassword(req.body.password, (err, isMatch) => {
            if(!isMatch) return res.json({loginSuccess: false, message: "비밀번호가 틀렸습니다."})

            // 비밀번호 까지 맞다면 토큰을 생성하기

            user.generateToken((err, user) => {
                if(err) return res.status(400).send(err);
                
                // 토큰을 저장한다.
                    res.status(200)
                    .json({ loginSuccess: true, userId: user._id, token: user.token })       
            })
        })
    })
})


router.get('/logout', auth, (req, res) => {

    User.findOneAndUpdate({_id: req.user._id}, 
        {token: ""},
        (err, user) => {
            if(err) return res.json({ success: false, err })
            return res.status(200).send({
                success: true
            })
        })

})

router.get('/applogout', appauth, (req, res) => {

    User.findOneAndUpdate({_id: req.user._id}, 
        {token: ""},
        (err, user) => {
            if(err) return res.json({ success: false, err })
            return res.status(200).send({
                success: true
            })
        })

})

router.get('/friends', (req, res) => {

    let _id = req.query.id;

    let userId = new ObjectId(_id)

    User.find({_id : { $ne : {_id : userId}}})
    .exec((err, data) => {
        if(err) return res.json({ success: false, err })
        return res.status(200).send(data);
    })


})



module.exports = router;
