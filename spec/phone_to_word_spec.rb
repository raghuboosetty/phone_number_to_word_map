require "spec_helper"

RSpec.describe "PhoneToWord", type: :aruba do
  describe "to_words" do
    context "given correct input params: 2282668687" do
      it "returns should return correct word combinations" do
        phone_to_word = PhoneToWord.new(max_word_sets: 2, phone_number: 2282668687)
        expect(phone_to_word.to_words).to eql([["catamounts"], ["act", "amounts"], ["act", "contour"], ["bat", "amounts"], ["bat", "contour"], ["cat", "amounts"], ["cat", "contour"], ["acta", "mounts"]])
      end
    end

    context "given correct input params: 6686787825" do
      it "returns should return correct word combinations" do
        phone_to_word = PhoneToWord.new(max_word_sets: 2, phone_number: 6686787825)
        expect(phone_to_word.to_words).to eql([["motortruck"], ["noun", "struck"], ["onto", "struck"], ["motor", "truck"], ["motor", "usual"], ["nouns", "truck"], ["nouns", "usual"]])
      end
    end

    context "given incorrect input params with 0s and 1s: 1083383838" do
      it "should throw exception" do
        expect { PhoneToWord.new(phone_number: 1083383838) }.to raise_error(Errno::EISDIR)
      end
    end
  end
end
