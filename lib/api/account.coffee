
module.exports = (app)->

	# For TEST
	app.get '/api/login', (req, res)->
		userName = req.body.username
		userPass = req.body.password

		# todo: check authorization
		user = {
			id: '106'
			name: 'chenhuagh'
			skey: '1kef1u94g8q90hef80y4rt90'
		}

		res.cookie 'userid', user.id
		res.cookie 'username', user.name
		res.cookie 'skey', user.skey
		res.cookie('avatar', 'http://a.disquscdn.com/uploads/users/6818/2203/avatar92.jpg?1376936026')

		###
			POST: http://themes.c-launcher.com/user/login2.do
			{"code":100}
			100 登录成功
			301 登录失败
			203 用户名错误
			204 密码错误
		###
		setTimeout ->
			res.jsonp 200, { code: 100 }
		, 3000

###
从明天起，做一个幸福的人，
喂马，劈柴，周游世界

从明天起，关心粮食和蔬菜，
我有一所房子，面朝大海，春暖花开

从明天起，和每一个亲人通信 ，
告诉他们我的幸福，
那幸福的闪电告诉我的，我将告诉每一个人

给每一条河，每一座山， 取一个温暖的名字

陌生人，我也为你祝福，
愿你有一个灿烂的前程
愿你有情人终成眷属
愿你在尘世获得幸福

我只愿面朝大海，春暖花开
###
