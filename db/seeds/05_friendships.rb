user1 = User.find(1)
user2 = User.find(2)

user1.requests_friendship(user2)

user3 = User.find(3)

user1.requests_friendship(user3)
user3.confirms_friendship(user1)

user4 = User.find(4)
user4.requests_friendship(user1)

