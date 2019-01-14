class PhoneToWord
  def initialize(options={})
    @min_word_length = options[:min_word_length] || 3
    @max_phone_length = options[:max_phone_length] || 10

    @word_hash = {}
    puts 'Initializing...'
    File.read("dictionary.txt").split("\n").each do |word|
      @word_hash[word] = ''
      word.split('').each do |letter|
        case letter.downcase
          when 'a', 'b', 'c'
            @word_hash[word] += '2'
          when 'd', 'e', 'f'
            @word_hash[word] += '3'
          when 'g', 'h', 'i'
            @word_hash[word] += '4'
          when 'j', 'k', 'l'
            @word_hash[word] += '5'
          when 'm', 'n', 'o'
            @word_hash[word] += '6'
          when 'p', 'q', 'r', 's'
            @word_hash[word] += '7'
          when 't', 'u', 'v'
            @word_hash[word] += '8'
          when 'w', 'x', 'y', 'z'
            @word_hash[word] += '9'
        end
      end
      # word_hash[word] = word_hash[word].to_i
    end
    @word_hash

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
  end

  def to_words
    words = []
    phone_number_combinations.each do |combination|
      part_words = []
      combination.each do |part_number|
        word = @word_hash.key(part_number)
        part_words << word.downcase if word
      end
      words << part_words if part_words.size == combination.size
    end
    words
  end
end

phone_to_word = PhoneToWord.new
phone_to_word.to_words
