What you see in the picture is a bug when running rspec.
I stopped the execution of rspec with a byebug statement inside the test.
Then I sent this command into the byebug console:

sender.sent_friendships

Pay attention to friendship 3
shows 5 friendships, each one with the 'confirmed' field false. Which is a problem because friendship with 'id' equals 3 is confirmed. As you can see when running this command

sender.sent_friendships.find(3)

It shows a friendship with a 'confirmed' field equals to true, wich is inconsistent with previous displays.

The solution(if we can call this solution) to this problem is to do this

sender.sent_friendships.map{|f| f.id}.map{|id| Friendship.find(id)}


------------------------

Doing the process(a user sends 5 friend requests to 5 more users) I couldn't find any inconsistency



