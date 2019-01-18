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

A test suite is added under `phone_number_to_word_map/spec` dir. Test coverage is on each method of `PhoneNumberToWord` class. You can run the test suite from `phone_number_to_word_map` dir by running:
```
$ bin/run_specs

# alternatively you can also use `rspec` command to run the tests:
$ rspec /spec
```

## Benchmarks
The problem statement asks to convert phone to words under 1000ms. I've taken the reverse appraoch of finding the words from given dictonary i.e format the given `txt` dictonary, then create a JSON hash at once and find the words in it with the keys. So the benchmarks in <b>realtime</b> are some what like this:
<br><br>
Converting the phone to word using the indexed dictonary: <b>50 - 200ms</b><br>
For inexing the whole dictonary and converting phone to words: <b>1200 - 1900ms</b>
<br><br>
The variable range of execution mostly depends on the hardware you are using. My hardware is pretty old and I was getting the execution time around 100ms for converting phone to words. A better hard ware can get things done in almost 1000ms for both indexing and conversion!
<br><br>
When you run the program you'll see the benchmarks only in <b>realtime</b>


## Logic
1. Parse the dictonary at once and write the data to a JSON file. Basically write once and read many. This helps in optimizing the performance of the application. It can also be done using DB with indexing and(or) searching libraries like elasticsearch as a next level of performance
2. Read the file at the time of initalization
3. Take the phone number as input from console, until the correct input is given by user. If user enters a number which is greater than or less than 10 or if 10 digit includes 0s and 1s then it will prompt for input again.
4. Once the correct input is given, it splits the given number into `n` sets of a 2D array. Based on the conditions i.e min. length to be 3 and max. size of each set to be 2.
5. Based on the combinations obtained, it iterates over them and fetches the word(s) from the JSON file, which forms a new 2D array, basically it's just mapping of phone to word(s)
6. These words are then combined within the sets to form final words.

## Deep Detail
The output of program is slightly different form the output obtained but I believe solution is correct. Please update for any issues involved:
1. Single words are wrapped in array in this program output but problem example output is showing as string
2. Some combinations are missing in given example. E.g: ['motor', 'truck'], ["cat", "amounts"], it can be assumed that full word 'motortruck' and 'catamounts' are used instead. If we consider that case then, ["acta", "mounts"] and ["act", "amounts"] shouldn't exist as they both are same when combined. Similarly ["noun", "struck"] and ["nouns", "truck"] shouldn't be there
<br><br>

Max. effort has been put to make the code dynamic also taking performance into account. So, most of the inputs given in problem are converted to params to new method. Thus extending the scope of the application.
<br><br>
Alter `bin/run` to change the input params for the `PhoneToWord#new`
<br>
e.g: 
* max_word_sets: integer(default: 2)<br>
  The number of sets a phone number needs to be broken into. The problem shows the set size to be 2.
* max_phone_length: integer(default: 10)<br> 
  The phone number length is 10 in the given problem, but I've made the scope to be dynamic where user can given any length of inputs
* min_word_length: integer (default: 3)<br>
  Min. number of words that each set need to have. Given input length is 3 but it can be changed to any number that user wants
* refresh_dictonary_json: boolean (default: false)<br>
  To refresh the JSON file whenever a dictonary is upated. This is one time operation. Setting the flag to true will update the JSON or if the file is missing then it will create a new one
* phone_number: integer/string (default: 0)<br>
  It can be given as an input param or can be given via console. When no input is given the console will prompt for input again until some input is given. 
  When an incorrect input is given(either more or less than 10 digit or with 1s and 0s), then it will raise an `InvalidPhoneError` exception