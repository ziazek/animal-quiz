#!/usr/bin/env ruby 

require 'sequel'

# ask user to think of an animal.
# default animal = elephant
# save the current position of guessing (true is 1 and false is 0)
# if guessed wrong, ask for the correct animal.
# ask for a question.
# ask for the right answer.
# save the question as a leaf.
# save the 2 animals under the leaf. 

# create the nodes table
DB = Sequel.sqlite('./db/quiz.db')

DB.create_table? :nodes do
  primary_key :id
  String :type 
  String :position 
  String :description
end

nodes = DB[:nodes]
puts nodes.inspect