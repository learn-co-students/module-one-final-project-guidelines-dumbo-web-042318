Question.delete_all
Answer.delete_all
LinkAnswer.delete_all
Link.delete_all


# questions
q_1 = Question.create(question: "What was Tesla's middle name?")
q_2 = Question.create(question: "Is Honda a good car?")
q_3 = Question.create(question: "How many licks to get to the center of a tootsie pop?")
q_4 = Question.create(question: "Do you regret shaving your beard?")


# answers
a_1 = Answer.create(answer: "Tesla's middle name was 'Danger'", question: q_1)
a_2 = Answer.create(answer: "Honda is not a good race car", question: q_2)
a_3 = Answer.create(answer: "It would be three", question: q_3)
a_4 = Answer.create(answer: "Life is nothing but regrets", question: q_4)


# links
l_1 = Link.create(url: "Middle names of the world", comment: "Placeholder1")
l_2 = Link.create(url: "http://www.wikipedia", comment: "Placeholder2")
l_3 = Link.create(url: "Tesla's website", comment: "Placeholder3")
l_4 = Link.create(url: "Race Car website", comment: "Placeholder4")
l_5 = Link.create(url: "Gilette", comment: "Placeholder5")
l_6 = Link.create(url: "A book about shaving", comment: "Placeholder6")

# link_answers
l_1_a_1 = LinkAnswer.create(link: l_1, answer: a_1)
l_2_a_1 = LinkAnswer.create(link: l_2, answer: a_1)
l_3_a_1 = LinkAnswer.create(link: l_3, answer: a_1)
l_4_a_2 = LinkAnswer.create(link: l_4, answer: a_2)
l_5_a_4 = LinkAnswer.create(link: l_5, answer: a_4)
l_6_a_4 = LinkAnswer.create(link: l_6, answer: a_4)
