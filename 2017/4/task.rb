class PassphraseValidator
    def valid?(phrase)
        words = {}
        phrase.split(' ').each do |word|
            return false if words[word]
            words[word] = true
        end
        return true
    end
end

class AnagramPassphraseValidator
    def valid?(phrase)
        words = {}
        phrase.split(' ').each do |word|
            key = word_to_key(word)
            return false if words[key]
            words[key] = true
        end
        return true
    end

    def word_to_key(word)
        word.split('').sort.join('')
    end
end

class PassphraseCounter
    attr_accessor :validator
    def initialize(validator)
        @validator = validator
    end

    def count_valid_phrases(inputs)
        number = 0
        inputs.each { |phrase| number += 1 if validator.valid?(phrase) }
        number
    end
end