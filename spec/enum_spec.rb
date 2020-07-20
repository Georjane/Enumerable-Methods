require './enumerable'

describe Enumerable do
  let(:arr) { (1..5) }
  let(:animals) { %w[ant bear cat] }
  let(:array) { [1, 2, 4, 2] }
  let(:inj_arr) { (5..10) }

  describe '#my_each' do
    context 'When block given' do
      it 'returns itself' do
        expect(arr.my_each { |x| x * 2 }).to eql(1..5)
      end

      it 'returns itself' do
        expect(arr.my_each { |x| puts x * 2 }).to eql(1..5)
      end
    end

    context 'When no block given' do
      it 'returns an Enumerator' do
        expect(arr.my_each).to be_an Enumerator
      end
    end
  end

  describe '#my_each_with_index' do
    context 'When block given' do
      it 'returns itself' do
        expect(arr.my_each_with_index { |x, y| x * y }).to eql(1..5)
      end

      it 'returns itself' do
        expect(arr.my_each_with_index { |x, y| puts x * y }).to eql(1..5)
      end
    end

    context 'When no block given' do
      it 'returns an Enumerator' do
        expect(arr.my_each_with_index).to be_an Enumerator
      end
    end
  end

  describe '#my_select' do
    it 'Returns a new array containing all elements for which block returns a true' do
      expect(arr.my_select(&:even?)).to eql [2, 4]
    end

    it 'Returns a new array containing all elements for which block returns a true' do
      expect(%w[a b c d e f].my_select { |v| v =~ /[aeiou]/ }).to eql %w[a e]
    end
  end

  describe '#my_all?' do
    it 'Returns true if the block never returns false or nil.' do
      expect(animals.my_all? { |word| word.length >= 3 }).to be true
    end

    it 'Returns true if the block never returns false or nil.' do
      expect(animals.my_all? { |word| word.length >= 4 }).to be false
    end

    it 'Returns true if the block never returns false or nil.' do
      expect(animals.my_all? { |word| word == /t/ }).to be false
    end

    it 'Returns true if the block never returns false or nil.' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to be true
    end

    it 'Returns true if the block never returns false or nil.' do
      expect([nil, true, 99].my_all?).to be false
    end

    it 'Returns true if the block never returns false or nil.' do
      expect([].my_all?).to be true
    end
  end

  describe '#my_any?' do
    it 'returns true if the block ever returns a value other than false or nil.' do
      expect(animals.my_any? { |word| word.length >= 3 }).to be true
    end

    it 'Returns true if the block ever returns a value other than false or nil.' do
      expect(animals.my_any? { |word| word.length >= 4 }).to be true
    end

    it 'Returns true if the block ever returns a value other than false or nil.' do
      expect(animals.my_any? { |word| word == /d/ }).to be false
    end

    it 'Returns true if the block ever returns a value other than false or nil.' do
      expect([nil, true, 99].my_any?(Integer)).to be true
    end

    it 'Returns true if the block ever returns a value other than false or nil.' do
      expect([nil, true, 99].my_any?).to be true
    end

    it 'Returns true if the block ever returns a value other than false or nil.' do
      expect([].my_any?).to be false
    end
  end

  describe '#my_none?' do
    it 'Returns true if the block never returns true for all elements.' do
      expect(animals.my_none? { |word| word.length == 5 }).to be true
    end

    it 'Returns true if the block never returns true for all elements.' do
      expect(animals.my_none? { |word| word.length >= 4 }).to be false
    end

    it 'Returns true if the block never returns true for all elements.' do
      expect(animals.my_none? { |word| word == /d/ }).to be true
    end

    it 'Returns true if the block never returns true for all elements.' do
      expect([1, 3.14, 42].my_none?(Float)).to be false
    end

    it 'Returns true if the block never returns true for all elements.' do
      expect([].my_none?).to be true
    end

    it 'Returns true if the block never returns true for all elements.' do
      expect([nil].my_none?).to be true
    end

    it 'Returns true if the block never returns true for all elements.' do
      expect([nil, false].my_none?).to be true
    end

    it 'Returns true if the block never returns true for all elements.' do
      expect([nil, false, true].my_none?).to be false
    end
  end

  describe '#my_count' do
    it 'Returns the number of items. If an argument is given, the number of items that are equal to the argument are counted' do
      expect(array.my_count).to eql 4
    end

    it 'Returns the number of items. If an argument is given, the number of items that are equal to the argument are counted' do
      expect(array.my_count(2)).to eql 2
    end

    it 'Returns the number of items. If an argument is given, the number of items that are equal to the argument are counted' do
      expect(array.my_count(&:even?)).to eql 3
    end
  end

  describe '#my_map' do
    context 'When block given' do
      it 'Returns a new array with the results of running a block once for every element.' do
        expect(arr.my_map { |i| i * i }).to eql [1, 4, 9, 16, 25]
      end

      it 'Returns a new array with the results of running a block once for every element.' do
        expect(arr.my_map { 'cat' }).to eql %w[cat cat cat cat cat]
      end
    end

    context 'When block given' do
      it 'Returns to enumerator' do
        expect(arr.my_map).to be_an Enumerator
      end
    end
  end

  describe '#my_inject' do
    it 'Combines all elements by applying a binary operation, specified by a block or a symbol that names a method or operator.' do
      expect(inj_arr.my_inject { |sum, n| sum + n }).to eql 45
    end

    it 'Combines all elements by applying a binary operation, specified by a block or a symbol that names a method or operator.' do
      longest = animals.my_inject { |memo, word| memo.length > word.length ? memo : word }
      expect(longest).to eql 'bear'
    end

    it 'Combines all elements by applying a binary operation, specified by a block or a symbol that names a method or operator.' do
      expect(inj_arr.my_inject(:+)).to eql 45
    end

    it 'Combines all elements by applying a binary operation, specified by a block or a symbol that names a method or operator.' do
      expect(inj_arr.my_inject(1, :*)).to eql 151_200
    end
  end
end

describe '#multiply_els' do
  it 'Returns the product of the elements' do
    expect(multiply_els([1, 2, 4, 2])).to eql 16
  end
end
