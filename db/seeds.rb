Question.delete_all
Answer.delete_all
LinkAnswer.delete_all
Link.delete_all
Tag.delete_all
TagAnswer.delete_all


# questions
q_1 = Question.create(question: "What is LeanLogr?")
q_2 = Question.create(question: "What was something you struggled to build")
q_3 = Question.create(question: "How did you ultimately implement that struggle in your code?")
q_4 = Question.create(question: "What are three things you learned working on this project?")
q_5 = Question.create(question: "What would you change or add to what you have today?")
q_6 = Question.create(question: "Is there any code you would like to highlight from this?")
q_7 = Question.create(question: "How do you switch to your default version of Ruby with RVM?")


# answers
a_1 = Answer.create(answer: "LeanLogr is a lightweight CLI app for organizing quick notes", question: q_1)
a_2 = Answer.create(answer: "This was our first Active Record app, so we took a while to make sure all our relationships were set up right.", question: q_2)
a_3 = Answer.create(answer: "Checked those docs, checked our syntax, used those macros. Bothered MANY teachers.", question: q_3)
a_4 = Answer.create(answer: "1. Time management is crucial 2. How to do Active Record migrations 3. White board Skillz.", question: q_4)
a_5 = Answer.create(answer: "We don't love how we set up the class structure, too many class methods, not enough instance methods.", question: q_5)
a_6 = Answer.create(answer: "No.", question: q_6)
a_7 = Answer.create(answer: "In the command line, just do '$ rvm default' and then check with '$ ruby -v'", question: q_7)


# links

l_1 = Link.create(url: "https://github.com/MostlyFocusedMike/module-one-final-project-guidelines-dumbo-web-042318", comment: "Here is LeanLogr's github link")
l_2 = Link.create(url: "https://github.com/learn-co-students/module-one-final-project-guidelines-dumbo-web-042318/blob/master/README.md", comment: "Here are the project guidelines we had to follow")
l_3 = Link.create(url: "https://rvm.io/rubies/default", comment: "Here are the RVM docs that deal with all things default")

# link_answers
l_1_a_1 = LinkAnswer.create(link: l_1, answer: a_1)
l_2_a_1 = LinkAnswer.create(link: l_2, answer: a_1)
l_3_a_7 = LinkAnswer.create(link: l_3, answer: a_7)

#tags
t_1 = Tag.create(t_content: "flatiron")
t_2 = Tag.create(t_content: "guidelines")
t_3 = Tag.create(t_content: "ruby")

#tag_answers
t_1_a_1 = TagAnswer.create(tag: t_1, answer: a_1)
t_1_a_2 = TagAnswer.create(tag: t_1, answer: a_2)
t_1_a_3 = TagAnswer.create(tag: t_1, answer: a_3)
t_1_a_4 = TagAnswer.create(tag: t_1, answer: a_4)
t_1_a_5 = TagAnswer.create(tag: t_1, answer: a_5)
t_1_a_6 = TagAnswer.create(tag: t_1, answer: a_6)
t_2_a_6 = TagAnswer.create(tag: t_2, answer: a_1)
t_3_a_1 = TagAnswer.create(tag: t_3, answer: a_1)
t_3_a_7 = TagAnswer.create(tag: t_3, answer: a_7)
