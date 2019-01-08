class MyFileError < IOError; end
# rth
module FileUtils
  def self.count_characters(filename)
    raise MyFileError, "#{filename} is not valid" unless File.readable?(filename)

    text = File.read(filename).delete(' ').split('')
    hash = {}
    text.each do |v|
      hash[v] = 0 if hash[v].nil?
      hash[v] += 1
    end
    hash
  end
end

puts FileUtils.count_characters('data/gruselett.txt')

