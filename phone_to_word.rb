require 'yaml'
class PhoneToWord
  def initialize(options={})

    # min. word length that needs to be created from dictonary
    # assignment defaults to 3 but it can be modified here
    @min_word_length = options[:min_word_length] || 3

    # the assignment defaults to 10 digit phone number
    # but the code is updated to take phone number of any size
    @max_phone_length = options[:max_phone_length] || 10

    # number sets the phone number needs to be broken into
    # based on the example output given, the size should be 2
    # however, the decription isn't talking about the size
    @max_word_sets = options[:max_word_sets]

    # the dictonary holds many words and looping it every time will consume more time
    # instead loop one and write to file(yml) and read it next time
    # symbols are faster than loops
    # every time dictonary is updated the file can be refershed with :refresh_dictonary_hash attribute
    if !!options[:refresh_dictonary_hash] || !File.file?('dictonary_hash.yml')
      puts 'Refreshing Dictonary...'
      @word_hash = Hash.new { |h, k| h[k] = Array.new }
      init_word_hash!(@word_hash, @max_phone_length)
    else
      puts 'Loading Dictonary...'
      @word_hash = YAML.load(File.read("dictonary_hash.yml"))      
    end

    # loop until a valid phone is given
    # a valid phone is
    # - @max_phone_length digit
    # - without 0s and 1s
    @phone_number = nil
    while !valid_phone?(@phone_number)
      puts "Please enter a valid 10 digit phone number without binary numbers(0's and 1's):"
      @phone_number = gets.chomp
    end
  end

  # checks if given phone number is valid
  # - length of phone should be @max_phone_length (assignment has a length of 10)
  # - phone number shouldn't include 0s or 1s or it should be within 2 to 9
  def valid_phone?(phone_number)
    phone_number && phone_number.length == @max_phone_length && phone_number.match(/^[2-9]*$/)
  end

  # returns different combinations of phone number with a min. @min_word_length
  # here in the assignment case, @min_word_length is 3
  def phone_number_combinations(phone_number = @phone_number)
    combination = (phone_number.length < @min_word_length) ? [] : [[phone_number]]
    max = [@max_phone_length, phone_number.length].min
    (@min_word_length...max).inject(combination) do |combination, i|
      phone_number_combinations(phone_number[i..-1]).inject(combination) do |combination, tail|
        combination.push([phone_number[0...i]] + tail)
      end
    end
    combination
  end

  # NOTE: this code returns only the combinations of phone number in 2 sets
  # def phone_number_combinations
  #   combinations = [[@phone_number]]
  #   10.times do |i|
  #     next if i < 2 || @phone_number[i + 1..-1].length < 3
  #     combinations <<  [@phone_number[0..i], @phone_number[i + 1..-1]]
  #   end
  #   combinations
  # end

  # converts phone number sets to words based on given dictonary
  # iterates over phone number sets and creates word sets
  # these words sets are again combined to form final set of combinations
  def to_words
    word_sets = []
    phone_number_combinations.each do |combination|
      part_words = []
      combination.each do |part_number|
        word_arr = @word_hash[part_number]
        part_words << word_arr if !word_arr.nil? && !word_arr.empty?
      end
      word_sets << part_words if part_words.size == combination.size
    end

    words = []
    word_sets.each do |word_set|
      next if @max_word_sets && word_set.size > @max_word_sets
      first_set, *rest_set = word_set
      words += first_set.product(*rest_set)
    end
    words
  end

private
  # reverse mapping of word to number in hash format of all the dictonary words
  # ideally standards way to do would be to either
  # - put the data to DB and index the column
  # - or use searching libraries like elasticsearch
  def init_word_hash!(word_hash, max_phone_length)
    File.read("dictionary.txt").split("\n").each do |word|
      next if word.length > max_phone_length
      number = '' 
      word.split('').each do |letter|
        case letter.downcase
          when 'a', 'b', 'c';      number += '2'
          when 'd', 'e', 'f';      number += '3'
          when 'g', 'h', 'i';      number += '4'
          when 'j', 'k', 'l';      number += '5'
          when 'm', 'n', 'o';      number += '6'
          when 'p', 'q', 'r', 's'; number += '7'
          when 't', 'u', 'v';      number += '8'
          when 'w', 'x', 'y', 'z'; number += '9'
        end
      end
      word_hash[number] << word.downcase
    end
    File.open("dictonary_hash.yml", "w") { |file| file.write(word_hash.to_yaml) }
  end
end


# options
# - max_word_sets: integer (default: nil)
# - max_phone_length: integer (default: 10)
# - min_word_length: integer (default: 3)
# - refresh_dictonary_hash: boolean (default: false)
phone_to_word = PhoneToWord.new(max_word_sets: 2)
puts phone_to_word.to_words.inspect
