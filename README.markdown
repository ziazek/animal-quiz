# Animal Quiz

## About

Best of Ruby Quiz, Chapter 4

A self-learning program. 

The program starts by telling the user to think of an animal. It then begins asking a series of yes/no questions about that animal: Does it swim? Does it have hair? And so on.... Eventually, it will narrow down the possibilities to a single animal and guess: is it a mouse?

If the program has guessed correctly, the game is over and may be restarted with a new animal. If the program has guessed incorrectly, it asks the user for the kind of animal they were thinking of and then asks for the user to provide a question that can distinguish between its incorrect guess and the correct answer. It then adds the new question and animal to its “database” and will guess that animal in the future (if appropriate). Your program should remember what it has learned between runs.

## Requirements

Ruby 2.2.2

Sqlite3

## Usage

run `bundle install`
`$ ./animal_quiz.rb`
Prints all database entries on exit

## Ideas

- Use Sqlite3 to store animal data.
- Consider a binary tree.
- Consider using RubyTree gem. (seems to have no persistence - moving on...)
- Consider using Sequel gem.

useful ideas  on using SQL for tree structures: [SO Answer](http://stackoverflow.com/a/10524722/575388)

## Results

A sample run:
![sample run](https://www.dropbox.com/s/r82vp8hi2u2qovb/Screenshot%202015-06-11%2011.24.47.png?raw=1)

## License

This code is released under the [MIT License](http://www.opensource.org/licenses/MIT)


