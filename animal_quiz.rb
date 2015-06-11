#!/usr/bin/env ruby 

require 'sequel'
require 'pry'

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
DB.timezone = :local

DB.create_table? :nodes do
  primary_key :id
  String :type 
  String :position 
  String :description
  DateTime :created_at
  DateTime :updated_at
end

class Node < Sequel::Model
  plugin :timestamps
end

class Quiz
  attr_accessor :position, :node, :current_answer

  def initialize
    @position = ""
    puts "Think of an animal..."
    sleep 0.5
  end

  def ask
    # find the node at current position
    self.node = next_node
    ask_question_or_animal
    # increment the position
    self.position += self.current_answer
    # if next node, ask again
    if next_node
      ask
    elsif self.current_answer == "y" 
      success
      play_again
    else
      get_new_question
      play_again
    end
  end

  def ask_question_or_animal
    # if animal, ask "Is it an #{animal}"
    begin
      if self.node.type == "animal"
        print "Is it #{self.node.description}? (y or n) "
      else
        # if question, ask the question.
        print "#{self.node.description} (y or n) "
      end
      self.current_answer = gets.chomp.downcase
      raise unless /^[yn]$/ =~ self.current_answer
    rescue
      puts "invalid answer"
      retry
    end
  end

  def next_node
    Node[position: position]
  end

  def success
    puts "I win. Pretty smart, aren't I?"
  end

  def get_new_question
    # remove last character of position (always "n")
    self.position.chomp!("n")

    puts "You win. Help me learn from my mistake before you go..."
    puts "What animal were you thinking of?"
    animal = gets.chomp
    puts "Give me a question to distinguish #{animal} from #{self.node.description}."
    question = gets.chomp
    print "For #{animal}, what is the answer to your question? (y or n) "
    answer = gets.chomp.downcase

    # save question at current position
    new_q = Node.new(type: 'question', position: self.position, description: question)
    puts "saving #{new_q.inspect}"
    new_q.save
    # save provided animal at current position + answer 
    new_animal = Node.new(type: 'animal', position: self.position + answer, description: animal)
    puts "saving #{new_animal.inspect}"
    new_animal.save
    # save current node animal at current position + opposite of answer
    self.node.position = self.position + opposite_of(answer)
    puts "saving #{self.node.inspect}"
    self.node.save
  end

  def play_again
    print "Play again? (y or n) "
    if gets.chomp == "y"
      self.position = ""
      ask
    else 
      puts Node.all.inspect
      exit 
    end
  end

  def opposite_of(answer)
    answer == "y" ? "n" : "y"
  end
end

# if no nodes exist, set up elephant as the initial node.
unless Node.all.any?
  elephant = Node.new(type: 'animal', position: '', description: 'an elephant')
  elephant.save
end

# start questioning in a loop
quiz = Quiz.new
quiz.ask