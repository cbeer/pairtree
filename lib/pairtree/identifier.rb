module Pairtree
  class Identifier
    ENCODE_REGEX = Regexp.compile("[\"*+,<=>?\\\\^|]|[^\x21-\x7e]", nil, 'u')
    DECODE_REGEX = Regexp.compile("\\^(..)", nil, 'u')
    def self.encode id
      id.gsub(ENCODE_REGEX) { |c| char2hex(c) }.tr('/:.', '=+,')
    end

    def self.decode id
      id.tr('=+,', '/:.').gsub(DECODE_REGEX) { |h| hex2char(h) } 
    end

    def self.char2hex c
      c.unpack('H*')[0].scan(/../).map { |x| "^#{x}"}
    end

    def self.hex2char h
       '' << h.delete('^').hex
    end
  end
end
