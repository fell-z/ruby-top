# Ruby Projects

Here is where I store my ruby projects of [TOP](https://theodinproject.com),
decided to keep all of them in one place.

---

## Projects

1. Caesar Cipher, the simplest and most widely known encryption techniques. It is a type of
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
