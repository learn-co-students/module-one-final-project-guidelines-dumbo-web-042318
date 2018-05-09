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
a_1 = Answer.create(answer: "Tesla's middle name was 'Danger'", question_id: 1)
a_2 = Answer.create(answer: "Honda is not a good race car", question_id: 2)
a_3 = Answer.create(answer: "3", question_id: 3)
a_4 = Answer.create(answer: "Life is nothing but regrets", question_id: 4)


# link_answers
l_1_a_1 = LinkAnswer.create(link_id: 1, answer_id: 1)
l_2_a_1 = LinkAnswer.create(link_id: 2, answer_id: 1)
l_3_a_1 = LinkAnswer.create(link_id: 3, answer_id: 1)
l_4_a_2 = LinkAnswer.create(link_id: 4, answer_id: 2)
l_5_a_4 = LinkAnswer.create(link_id: 5, answer_id: 4)
l_6_a_4 = LinkAnswer.create(link_id: 6, answer_id: 4)

# links
l_1 = Link.create(url: "Middle names of the world", comment: "Placeholder1")
l_2 = Link.create(url: "http://www.wikipedia", comment: "Placeholder2")
l_3 = Link.create(url: "Tesla's website", comment: "Placeholder3")
l_4 = Link.create(url: "Race Car website", comment: "Placeholder4")
l_5 = Link.create(url: "Gilette", comment: "Placeholder5")
l_6 = Link.create(url: "A book about shaving", comment: "Placeholder6")
