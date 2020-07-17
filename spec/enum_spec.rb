require './enumerable'

describe Enumerable do
  let(:arr) { (1..5) }

  describe '#my_each' do
    it 'returns itself' do
      expect(arr.my_each{ |x| x * 2}).to eql (1..5)
    end
  end

  describe '#my_each_with_index' do
    it 'returns itself' do
      expect(arr.my_each_with_index{ |x, y| x * y}).to eql (1..5)
    end
  end

  describe '#my_select' do
    it 'Returns a new array containing all elements for which block returns a true' do
      expect(arr.my_select { |num|  num.even?  }).to eql [2, 4]
    end

    it 'Returns a new array containing all elements for which block returns a true' do
      a = %w{ a b c d e f }
      expect(a.my_select { |v| v =~ /[aeiou]/ }).to eql ["a", "e"]
    end
  end
end