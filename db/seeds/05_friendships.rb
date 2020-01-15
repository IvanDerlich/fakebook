user = User.find(1)

user.requests_friendship(User.find(2))
user.requests_friendship(User.find(3))

user.requests_friendship(User.find(4))
User.find(4).confirms_friendship(user)

user.requests_friendship(User.find(5))
User.find(5).confirms_friendship(user)

User.find(6).requests_friendship(user)
User.find(7).requests_friendship(user)
User.find(8).requests_friendship(user)
User.find(9).requests_friendship(user)
User.find(10).requests_friendship(user)
User.find(11).requests_friendship(user)