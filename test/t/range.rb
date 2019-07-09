##
# Range ISO Test

assert('Range', '15.2.14') do
  assert_equal Class, Range.class
end

assert('Range#==', '15.2.14.4.1') do
  assert_true (1..10) == (1..10)
  assert_false (1..10) == (1..100)
  skip unless Object.const_defined?(:Float)
  assert_true (1..10) == Range.new(1.0, 10.0)
end

assert('Range#===', '15.2.14.4.2') do
  a = (1..10)

  assert_true a === 5
  assert_false a === 20
end

assert('Range#begin', '15.2.14.4.3') do
  assert_equal 1, (1..10).begin
end

assert('Range#each', '15.2.14.4.4') do
  a = (1..3)
  b = 0
  a.each {|i| b += i}
  assert_equal 6, b
end

assert('Range#end', '15.2.14.4.5') do
  assert_equal 10, (1..10).end
end

assert('Range#exclude_end?', '15.2.14.4.6') do
  assert_true (1...10).exclude_end?
  assert_false (1..10).exclude_end?
end

assert('Range#first', '15.2.14.4.7') do
  assert_equal 1, (1..10).first
end

assert('Range#include?', '15.2.14.4.8') do
  assert_true (1..10).include?(10)
  assert_false (1..10).include?(11)

  assert_true (1...10).include?(9)
  assert_false (1...10).include?(10)
end

assert('Range#initialize', '15.2.14.4.9') do
  a = Range.new(1, 10, true)
  b = Range.new(1, 10, false)

  assert_equal (1...10), a
  assert_true a.exclude_end?
  assert_equal (1..10), b
  assert_false b.exclude_end?

  assert_raise(NameError) { (0..1).__send__(:initialize, 1, 3) }
end

assert('Range#last', '15.2.14.4.10') do
  assert_equal 10, (1..10).last
end

assert('Range#member?', '15.2.14.4.11') do
  a = (1..10)

  assert_true a.member?(5)
  assert_false a.member?(20)
end

assert('Range#to_s', '15.2.14.4.12') do
  assert_equal "0..1", (0..1).to_s
  assert_equal "0...1", (0...1).to_s
  assert_equal "a..b", ("a".."b").to_s
  assert_equal "a...b", ("a"..."b").to_s
end

assert('Range#inspect', '15.2.14.4.13') do
  assert_equal "0..1", (0..1).inspect
  assert_equal "0...1", (0...1).inspect
  assert_equal "\"a\"..\"b\"", ("a".."b").inspect
  assert_equal "\"a\"...\"b\"", ("a"..."b").inspect
end

assert('Range#eql?', '15.2.14.4.14') do
  assert_true (1..10).eql? (1..10)
  assert_false (1..10).eql? (1..100)
  assert_false (1..10).eql? (Range.new(1.0, 10.0))
  assert_false (1..10).eql? "1..10"
end

assert('Range#initialize_copy', '15.2.14.4.15') do
  assert_raise(NameError) { (0..1).__send__(:initialize_copy, 1..3) }
end

assert('Range#dup') do
  r = (1..3).dup
  assert_equal r.begin, 1
  assert_equal r.end, 3
  assert_false r.exclude_end?

  r = ("a"..."z").dup
  assert_equal r.begin, "a"
  assert_equal r.end, "z"
  assert_true r.exclude_end?
end

assert('Range#max') do
  assert_equal 10, (1..10).max
  assert_equal 9, (1...10).max
  assert_equal nil, (10..1).max
  assert_equal nil, (10...1).max

  # equal endpoints
  assert_equal 5, (5..5).max
  assert_equal nil, (5...5).max

  # block overrides comparison
  assert_equal(10, (1..10).max { |a, b| a <=> b })
  assert_equal(9, (1...10).max { |a, b| a <=> b })
  assert_equal(nil, (10..1).max { |a, b| a <=> b })
  assert_equal(nil, (10...1).max { |a, b| a <=> b })
  assert_equal(1, (1..10).max { |a, b| b <=> a })
  assert_equal(1, (1...10).max { |a, b| b <=> a })
  assert_equal(nil, (10..1).max { |a, b| b <=> a })
  assert_equal(nil, (10...1).max { |a, b| b <=> a })
end

assert('Range#min') do
  assert_equal 1, (1..10).min
  assert_equal 1, (1...10).min
  assert_equal nil, (10..1).min
  assert_equal nil, (10...1).min

  # equal endpoints
  assert_equal 7, (7..7).min
  assert_equal nil, (7...7).min

  # block overrides comparison
  assert_equal(1, (1..10).min { |a, b| a <=> b })
  assert_equal(1, (1...10).min { |a, b| a <=> b })
  assert_equal(nil, (10..1).min { |a, b| a <=> b })
  assert_equal(nil, (10...1).min { |a, b| a <=> b })
  assert_equal(10, (1..10).min { |a, b| b <=> a })
  assert_equal(9, (1...10).min { |a, b| b <=> a })
  assert_equal(nil, (10..1).min { |a, b| b <=> a })
  assert_equal(nil, (10...1).min { |a, b| b <=> a })
end
