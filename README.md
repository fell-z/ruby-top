# Ruby Projects

Here is where I store my ruby projects of [TOP](https://theodinproject.com),
decided to keep all of them in one place.

---

## Projects

1. Project - Caesar Cipher, the simplest and most widely known encryption techniques. It is a type of
substitution cipher in which each letter in the plaintext is replaced by a letter some fixed number of
positions down the alphabet.

2. Project - Sub Strings, a method that takes a phrase as the first argument and with a dictionary of words given
as the second argument, if a sub string in the dictionary is found in a word of the phrase, it will increase the
counter for that word, e.g.
```ruby
dictionary = ["go", "going", ...]
substrings("Howdy partner, sit down! How's it going?", dictionary)
=> {"go"=>1, "going"=>1, ...} # the phrase doesn't contain the word "go", but it's found as a sub string in "going", so the counter go up anyways.
```
