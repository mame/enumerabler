module Enumerable
  def grepper(pat, &blk)
    Enumerator.new do |e|
      each do |x|
        e << (blk ? blk[x] : x) if pat === x
      end
    end
  end

  def finder_all(&blk)
    Enumerator.new do |e|
      each do |x|
        e << x if blk[x]
      end
    end
  end
  alias all_finder finder_all
  alias selector finder_all

  def rejecter(&blk)
    Enumerator.new do |e|
      each do |x|
        e << x unless blk[x]
      end
    end
  end

  def collector(&blk)
    Enumerator.new do |e|
      each do |x|
        e << blk[x]
      end
    end
  end
  alias mapper collector

  def flat_mapper(&blk)
    Enumerator.new do |e|
      each do |a|
        blk[a].each do |x|
          e << x
        end
      end
    end
  end
  alias concat_collector flat_mapper

  def zipper(*ary, &blk)
    Enumerator.new do |e|
      if ary.all? {|a| a.is_a?(Array) }
        i = 0
        each do |x|
          e << [x] + ary.map {|a| a[i] }
          i += 1
        end
      else
        ary = ary.map! {|a| a.to_enum }
        each do |x|
          a = ary.map.with_index do |a, i|
            next nil if a == nil
            begin
              a.next
            rescue StopIteration
              ary[i] = nil
            end
          end
          e << [x] + a
        end
      end
    end
  end

  def taker(n)
    Enumerator.new do |e|
      i = 0
      each do |x|
        break if i == n
        e << x
        i += 1
      end
    end
  end

  def taker_while(&blk)
    Enumerator.new do |e|
      each do |x|
        break unless blk[x]
        e << x
      end
    end
  end

  def dropper(n)
    Enumerator.new do |e|
      i = 0
      each do |x|
        e << x if i >= n
        i += 1
      end
    end
  end

  def dropper_while(&blk)
    Enumerator.new do |e|
      flag = false
      each do |x|
        flag = true unless flag || blk[x]
        e << x if flag
      end
    end
  end
end
