require "spec_helper"

RSpec.describe "PhoneToWord" do
  describe "initialize" do
    context "given correct input params(10 digit phone number without 0s and 1s): 2282668687" do
      it "returns new phone_to_word instance" do
        phone_to_word = PhoneToWord.new(phone_number: 2282668687)
        expect(phone_to_word.class).to eql(PhoneToWord)
      end
    end

    context "given incorrect input params(10 digit phone number with 0s and 1s): 1081787825" do
      it "should throw InvalidPhoneError exception" do
        expect { PhoneToWord.new(phone_number: 1081787825) }.to raise_error(InvalidPhoneError)
      end
    end

    context "given incorrect input params with(less than 10 digit number with 0s and 1s) : 10817878" do
      it "should throw InvalidPhoneError exception" do
        expect { PhoneToWord.new(phone_number: 10817878) }.to raise_error(InvalidPhoneError)
      end
    end

    context "given incorrect input params with(less than 10 digit number without 0s and 1s) : 66867878" do
      it "should throw InvalidPhoneError exception" do
        expect { PhoneToWord.new(phone_number: 66867878) }.to raise_error(InvalidPhoneError)
      end
    end
  end

  describe "phone_number_combinations" do
    context "given correct input params(10 digit phone without 0s and 1s in integer): 2282668687" do
      it "should split the phone number into correct combinations" do
        combinations = PhoneToWord.new(phone_number: 2282668687).phone_number_combinations
        expected_output = [["2282668687"], ["228", "2668687"], ["228", "266", "8687"], ["228", "2668", "687"], ["2282", "668687"], ["2282", "668", "687"], ["22826", "68687"], ["228266", "8687"], ["2282668", "687"]]
        expect(combinations).to eql(expected_output)
        expect(combinations).to match_array(expected_output)
      end
    end

    context "given correct input params(10 digit phone without 0s and 1s in integer): 6686787825" do
      it "should split the phone number into correct combinations" do
        combinations = PhoneToWord.new(phone_number: 6686787825).phone_number_combinations
        expected_output = [["6686787825"], ["668", "6787825"], ["668", "678", "7825"], ["668", "6787", "825"], ["6686", "787825"], ["6686", "787", "825"], ["66867", "87825"], ["668678", "7825"], ["6686787", "825"]]
        expect(combinations).to eql(expected_output)
        expect(combinations).to match_array(expected_output)
      end
    end
  end

  describe "to_words" do
    context "given correct input params(10 digit phone without 0s and 1s in integer): 2282668687" do
      it "should return correct word combinations in an array" do
        words = PhoneToWord.new(phone_number: 2282668687).to_words
        expected_output = [["catamounts"], ["act", "amounts"], ["act", "contour"], ["bat", "amounts"], ["bat", "contour"], ["cat", "amounts"], ["cat", "contour"], ["acta", "mounts"]]
        expect(words).to eql(expected_output)
        expect(words).to match_array(expected_output)
      end
    end

    context "given correct input params(10 digit phone without 0s and 1s in integer): 6686787825" do
      it "should return correct word combinations in an array" do
        words = PhoneToWord.new(phone_number: 6686787825).to_words
        expected_output = [["motortruck"], ["noun", "struck"], ["onto", "struck"], ["motor", "truck"], ["motor", "usual"], ["nouns", "truck"], ["nouns", "usual"]]
        expect(words).to eql(expected_output)
        expect(words).to match_array(expected_output)
      end
    end

    context "given correct input params(10 digit phone without 0s and 1s in string): '6686787825'" do
      it "should return correct word combinations in an array" do
        words = PhoneToWord.new(phone_number: '6686787825').to_words
        expected_output = [["motortruck"], ["noun", "struck"], ["onto", "struck"], ["motor", "truck"], ["motor", "usual"], ["nouns", "truck"], ["nouns", "usual"]]
        expect(words).to eql(expected_output)
        expect(words).to match_array(expected_output)
      end
    end
  end

  describe "Benchmarks" do
    context "given correct input params" do
      it "should refresh the index the whole dictonary and convert the phone to words in less than 1900ms" do
        expect { 
          PhoneToWord.new(phone_number: 2282668687, refresh_dictonary_json: true) 
        }.to perform_under(1900).ms
      end

      it "should convert phone to words in sets of 2 in less than 200ms" do
        expect { 
          PhoneToWord.new(max_word_sets: 2, phone_number: 2282668687).to_words 
        }.to perform_under(200).ms
      end

      it "should convert phone to words in sets of 3 in less than 200ms" do
        expect { 
          PhoneToWord.new(max_word_sets: 3, phone_number: 2282668687).to_words 
        }.to perform_under(200).ms
      end
    end
  end
end
