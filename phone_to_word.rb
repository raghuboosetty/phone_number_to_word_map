class PhoneToWord
  def initialize(options={})
    @min_word_length = options[:min_word_length] || 3
    @max_phone_length = options[:max_phone_length] || 10

    @word_hash = Hash.new { |h, k| h[k] = Array.new }
    puts 'Initializing...'
    File.read("dictionary.txt").split("\n").each do |word|
      # @word_hash[word] = ''
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
      # puts @word_hash[number].size if @word_hash[number].size > 1
      # word_hash[word] = word_hash[word].to_i
    end
    # puts @word_hash.inspect
    # puts @word_hash['66867']

    @phone_number = nil
    while !valid_phone?(@phone_number)
      puts "Please enter a 10 digit phone number without 0's and 1's:"
      @phone_number = gets.chomp
    end
  end

  def valid_phone?(phone_number)
    phone_number && phone_number.length == 10 && phone_number.match(/^[2-9]*$/)
  end

  # def phone_number_combinations(phone_number = @phone_number)
  #   combination = (phone_number.length < @min_word_length) ? [] : [[phone_number]]
  #   max = [@max_phone_length, phone_number.length].min
  #   (@min_word_length...max).inject(combination) do |combination, i|
  #     phone_number_combinations(phone_number[i..-1]).inject(combination) do |combination, tail|
  #       combination.push([phone_number[0...i]] + tail)
  #     end
  #   end
  # end

  def phone_number_combinations
    combinations = [[@phone_number]]
    10.times do |i|
      next if i < 2 || @phone_number[i + 1..-1].length < 3
      combinations <<  [@phone_number[0..i], @phone_number[i + 1..-1]]
    end
    combinations
  end

  def to_words
    words = []
    phone_number_combinations.each do |combination|
      part_words = []
      combination.each do |part_number|
        word = @word_hash[part_number]
        part_words << word if !word.empty?
      end
      words << part_words if part_words.size == combination.size
    end

    word_sets = []
    words.each do |word_set|
      if word_set.size == 2
        word_set1, word_set2 = word_set
        word_set1.each_with_index do |set1, set1_index|
          word_set2.each_with_index do |set2, set2_index|
            word_sets << [word_set1[set1_index], word_set2[set2_index]]
          end
        end
      else
        word_sets << word_set.flatten
      end
    end
    word_sets
  end

  # def to_words
  #   words = []
  #   phone_number_combinations.each do |combination|
  #     part_words = []
  #     combination.each do |part_number|
  #       word = @word_hash[part_number]
  #       part_words << word.map(&:downcase) if word
  #     end
  #     words << part_words if part_words.size == combination.size
  #   end
  #   words
  # end
end

phone_to_word = PhoneToWord.new
puts phone_to_word.to_words.inspect
