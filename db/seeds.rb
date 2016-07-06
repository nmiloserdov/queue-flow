question_title = []
question_body  = []
answer_body    = []
comment_body   = []
user_email     = []
password       = []
users          = []

200.times { 
  question_title << Faker::StarWars.quote
  question_body  << Faker::Hipster.paragraph
  answer_body    << Faker::Hacker.say_something_smart
  comment_body   << Faker::Company.bs
  user_email     << Faker::Internet.email
  password       << Faker::Internet.password(10)
}

(0..99).each do |index|
  users << User.create!(email: user_email[index], password: password[index], password_confirmation: password[index])
end

(0..99).each do |index|
  puts "question #{index}"
  question = Question.create!(title: question_title[index],
    body: question_body[index], user_id: users[rand(99)].id)

  4.times { Answer.create!(question_id: question.id,
      body: answer_body[rand(99)], user_id: users[rand(99)].id) }

  3.times { Comment.create!(commentable: question,
    body: comment_body[index], user_id: users[rand(99)].id) }
end
