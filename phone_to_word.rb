class PhoneToWord
  def initialize(options={})
    @min_word_length = options[:min_word_length] || 3
    @max_phone_length = options[:max_phone_length] || 10

    @word_hash = Hash.new { |h, k| h[k] = Array.new }
    puts 'Initializing...'
    File.read("dictionary.txt").split("\n").each do |word|
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
      @word_hash[number] << word.downcase
    end

    @phone_number = nil
    while !valid_phone?(@phone_number)
      puts "Please enter a 10 digit phone number without 0's and 1's:"
      @phone_number = gets.chomp
    end
  end

  def valid_phone?(phone_number)
    phone_number && phone_number.length == 10 && phone_number.match(/^[2-9]*$/)
  end

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

  # def phone_number_combinations
  #   combinations = [[@phone_number]]
  #   10.times do |i|
  #     next if i < 2 || @phone_number[i + 1..-1].length < 3
  #     combinations <<  [@phone_number[0..i], @phone_number[i + 1..-1]]
  #   end
  #   combinations
  # end

  def to_words
    word_sets = []
    phone_number_combinations.each do |combination|
      part_words = []
      combination.each do |part_number|
        word_arr = @word_hash[part_number]
        part_words << word_arr if !word_arr.empty?
      end
      word_sets << part_words if part_words.size == combination.size
    end

    words = []
    word_sets.each do |word_set|
      # next if word_set.size > 2
      first_set, *rest_set = word_set
      words += first_set.product(*rest_set)
    end
    words
  end

  def to_phone
    
  end
end

phone_to_word = PhoneToWord.new
puts phone_to_word.to_words.inspect
