The problem statement is here: `/docs/problem`. Please go through it.

## Setup

First, install [Ruby](https://www.ruby-lang.org/en/documentation/installation/). 

Then run the following commands under the `phone_number_to_word_map` dir.

```
$ ruby -v # confirm ruby version | ruby 2.5.1
$ gem install bundler # install bundler to manage dependencies
$ bin/setup

```

## Usage

You can run the program from `phone_number_to_word_map` by giving command line input:

### Command line input
```sh
$ bin/run
# Please enter a valid 10 digit phone number without binary numbers(0's and 1's):
$ 6686787825
# Possible Words:
# [["motortruck"], ["noun", "struck"], ["onto", "struck"], ["motor", "truck"], ["motor", "usual"], ["nouns", "truck"], ["nouns", "usual"]]
# Time to execute: 0.31ms
```

## Unit Tests

A mini test suite is added under `phone_number_to_word_map/spec` dir. You can run the test suite from `phone_number_to_word_map` dir by running
```
$ bin/run_specs
```

## Logic
1. Parse the dictonary at once and write the data to a JSON file. Basically write once and read many. This helps in optimizing the performance of the application. It can also be done using DB with indexing and(or) searching libraries like elasticsearch as a next level of performance
2. Read the file at the time of initalization
3. Take the phone number as input from console, until the correct input is given by user. If user enters a number which is greater than or less than 10 or if 10 digit includes 0s and 1s then it will prompt for input again.
4. Once the correct input is given, it splits the given number into `n` sets of a 2D array. Based on the conditions i.e min. length to be 3 and max. size of each set to be 2.
5. Based on the combinations obtained, it iterates over them and fetches the word(s) from the JSON file, which forms a new 2D array, basically it's just mapping of phone to word(s)
6. These words are then combined within the sets to form final words.