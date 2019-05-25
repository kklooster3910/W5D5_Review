require 'byebug'

def range(start, finish) #1, 5 => [1,2,3,4]
    return [] if start == finish 

    [start] + range(start + 1, finish)
end

def exp(b, n)
    return 1 if n == 0

    b * exp(b, n -1)
end

def exp1(b, n)
    return 1 if n == 0
    return b if n == 1

    if n.even?
        b * exp1(b, n / 2)
    else
        b * (exp1(b, (n-1)/2) * b)
    end
end

def deep_dup(arr) #[1, [2], [3, [4]]]
    return arr.dup if arr.length <= 1
    # duped = []
    arr.map { |ele| ele.is_a?(Array) ? deep_dup(ele) : ele.dup }
    # duped
end

def fibs(n) #n = 5 [1, 1, 2, 3, 5, 8]
    # return [] if n == 0 
    # return [1] if n == 1
    # return [1, 1] if n ==2
    return [1,1].take(n) if n <= 2
    f = fibs(n - 1)
    f << f[-2] + f[-1]
end

def bsearch(array, target) # assume the array is sorted
    return nil if array.empty?
    mid = array.count / 2
    case target <=> array[mid]
    when -1
        bsearch(array.take(mid), target) 
    when 0
        mid
    when 1
        sub_idx = bsearch(array.drop(mid + 1), target)
        sub_idx.nil? ? nil : (mid + 1) + sub_idx
    end
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

class Array

    def merge_sort(&prc)
        prc ||= Proc.new { |x, y| x <=> y }
        return self if self.length <= 1
        mid = self.count / 2
        left, right = self.take(mid).merge_sort(&prc), self.drop(mid).merge_sort(&prc)
        Array.merge(left, right, prc)
    end

    private

    def self.merge(left, right, prc)
        mergy = []
        until left.empty? || right.empty?
            prc.call(left, right) <= 0 ? mergy << left.shift : mergy << right.shift
        end
        mergy.concat(left).concat(right)
    end

end

def subsets(arr) # subsets([1, 2, 3]) => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
    return [[]] if arr.empty?
    # debugger
    subs = subsets(arr[0...-1])
    subsets = []
    subs.each { |sub| subs << sub + [arr[-1]] }
    subs + subsets
end