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