require 'test/unit'
require './file_utils'
GRUSELETT = 'data/gruselett.txt'
EMPTY = 'data/empty.txt'
SIMPLE_01 = 'data/simple_test_file_01.txt'
# Test cases for the module FileUtils
# Author:: Bernd Kahlbrandt
class FileUtilsTest < Test::Unit::TestCase
  def test_count_character_values
    assert_equal(2, FileUtils.count_characters(GRUSELETT)['G'])
    assert_equal(10, FileUtils.count_characters(GRUSELETT)['e'])
    assert_equal(4, FileUtils.count_characters(GRUSELETT)["\n"])
    assert_raise(MyFileError){FileUtils.count_characters("data/gruselettt.txt")}
    assert(MyFileError.new().is_a?(IOError))
    assert_equal(25,FileUtils.count_characters(GRUSELETT).keys().count())
    assert_equal(108,FileUtils.count_characters(GRUSELETT).values().sum())
    assert_equal(1, FileUtils.count_characters(SIMPLE_01)['a'])
    assert_equal(1, FileUtils.count_characters(SIMPLE_01)['b'])
    assert_equal(1, FileUtils.count_characters(SIMPLE_01)['c'])
    assert_equal(3,FileUtils.count_characters(SIMPLE_01).values().sum())

  end

  def test_count_character_type
    refute(FileUtils.count_characters(GRUSELETT).empty?)
    assert(FileUtils.count_characters(EMPTY).empty?)
    assert(FileUtils.count_characters(EMPTY)['a'].nil?)
    assert(FileUtils.count_characters(GRUSELETT).is_a?(Hash))
  end
end