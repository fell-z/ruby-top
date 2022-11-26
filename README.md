# NOTICE

I decided to create repo to each one of the projects, make it a little more organized.

# Ruby Projects

Here is where I store my ruby projects of [TOP](https://theodinproject.com),
decided to keep all of them in one place.

---

## Projects

1. [Caesar Cipher](https://en.wikipedia.org/wiki/Caesar_cipher), the simplest and most widely known encryption techniques. It is a type of
substitution cipher in which each letter in the plaintext is replaced by a letter some fixed number of
positions down the alphabet.

2. Sub Strings, a method that takes a phrase as the first argument and with a dictionary of words given
as the second argument, if a sub string in the dictionary is found in a word of the phrase, it will increase the
counter for that word, e.g.
    ```ruby
    dictionary = ["go", "going", ...]
    substrings("Howdy partner, sit down! How's it going?", dictionary)
    => {"go"=>1, "going"=>1, ...} # the phrase doesn't contain the word "go", but it's found as a sub string in "going", so the counter go up anyways.
    ```

3. Stock Picker, a method that takes an array with stock prices, one for each day continuously. The method must return
a array with the best day(index) to buy and the best day(index) to sell, in this order. e.g.
    ```ruby
    stock_prices = [17, 3, 6, 9, 15, 8, 6, 1, 10]
    stock_picker(stock_prices)
    => [1, 4] # stock_prices[4] = 15 and stock_prices[1] = 3, so $15 - $3 = $12, profit $$$! 
    ```

4. [Bubble Sort](https://en.wikipedia.org/wiki/Bubble_sort), a simple(if not the simplest) sorting algorithm and typically the one you get taughted how to 
do it in Computer Science, impractical for real use, but good for learning the basics of sorting algorithms and Computer Science in general.

5. [Tic Tac Toe](https://en.wikipedia.org/wiki/Tic-tac-toe), a simple game made using my new OOP skills.

6. [Mastermind](https://en.wikipedia.org/wiki/Mastermind_(board_game)) is a code-breaking game for two players. This version
has differences in the rules, resembling more to the Wordle game.

7. Event Manager, this project differs from the others because it's a adaptation of a tutorial from
   Jump Start Lab, it mainly contains use cases with APIS like the 'Google Civic API' and the Ruby
   builtins classes like 'Time' and 'CSV'.

8. [Hangman](https://en.wikipedia.org/wiki/Hangman_(game)), a simple game written in the Ruby
   language, using my new serialization skills to implement a save and load game state feature.

9. [Recursion](https://en.wikipedia.org/wiki/Recursion_(computer_science)), recursion, the idea of a function that calls itself, used mostly in implementations of '[Divide-and-conquer](https://en.wikipedia.org/wiki/Divide-and-conquer_algorithm)' algorithms. This project uses recursion to implement a fibonacci sequence and the merge-sort algorithm.

10. [Linked lists](https://en.wikipedia.org/wiki/Linked_list), a linear data structure similar to an array, the difference is that: in the memory, each element is placed contiguously in an array, however, in a linked list, each element is called a node that have not only the data BUT a reference to the next element, that makes it easy to add and remove elements from the list. This project is a implementation of that.

11. [Binary search tree](https://en.wikipedia.org/wiki/Binary_search_tree)

12. Knight Travails, a knight in chess can move to any square on the standard 8x8 chess board from any other square on the board, this program compute and outputs the shortest path(minimum amount of moves) from a square to another.
