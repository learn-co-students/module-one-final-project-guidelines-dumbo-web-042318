Question.delete_all
Answer.delete_all
LinkAnswer.delete_all
Link.delete_all
Tag.delete_all
TagAnswer.delete_all


# questions
q_1 = Question.create(question: "What is Ruby?")
q_2 = Question.create(question: "Is Ruby a good language?")
q_3 = Question.create(question: "How many licks to get to the center of Bash?")
q_4 = Question.create(question: "Do you regret php?")


# answers
a_1 = Answer.create(answer: "Coding language/ gemstone(july)", question: q_1)
a_2 = Answer.create(answer: "YES!!!!!!!!!!!!!!!!", question: q_2)
a_3 = Answer.create(answer: "3... 3 licks to get to the center of Bash", question: q_3)
a_4 = Answer.create(answer: "Life is nothing but regrets", question: q_4)


# links
l_1 = Link.create(url: "www.RubyDocs", comment: "Ruby website")
l_2 = Link.create(url: "http://www.wikipedia", comment: "Ruby wikipedia")
l_3 = Link.create(url: "www.programmingRuby", comment: "Ruby")
l_4 = Link.create(url: "www.Languages", comment: "Languages")
l_5 = Link.create(url: "www.PHP", comment: "Php")
l_6 = Link.create(url: "www.PPHHPP", comment: "PHP2.0")

# link_answers
l_1_a_1 = LinkAnswer.create(link: l_1, answer: a_1)
l_2_a_1 = LinkAnswer.create(link: l_2, answer: a_1)
l_3_a_1 = LinkAnswer.create(link: l_3, answer: a_1)
l_4_a_2 = LinkAnswer.create(link: l_4, answer: a_2)
l_5_a_4 = LinkAnswer.create(link: l_5, answer: a_4)
l_6_a_4 = LinkAnswer.create(link: l_6, answer: a_4)

#tags
t_1 = Tag.create(t_content: "Ruby")
t_2 = Tag.create(t_content: "PHP")
t_3 = Tag.create(t_content: "Flatiron")

#tag_answers
t_1_a_1 = TagAnswer.create(tag: t_1, answer: a_1)
t_1_a_2 = TagAnswer.create(tag: t_1, answer: a_2)
t_2_a_4 = TagAnswer.create(tag: t_2, answer: a_4)
t_3_a_1 = TagAnswer.create(tag: t_3, answer: a_1)
t_3_a_2 = TagAnswer.create(tag: t_3, answer: a_2)
