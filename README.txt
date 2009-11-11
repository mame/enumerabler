= enumerabler

* http://github.com/mame/enumerabler/tree/master

== DESCRIPTION:

enumerabler enhances Enumerable with methods returning enumerator.

== FEATURES/PROBLEMS:

- Enumerable#grepper
- Enumerable#finder_all (alias: all_finder, selector)
- Enumerable#rejecter
- Enumerable#collector (alias: mapper)
- Enumerable#flat_mapper (alias: concat_collector)
- Enumerable#zipper
- Enumerable#taker
- Enumerable#taker_while
- Enumerable#dropper
- Enumerable#dropper_while

== SYNOPSIS:

  require "enumerabler"

  # `select' and `selector' have the almost same behavior.
  ary.select   {|x| x.even? }.take(10)
  ary.selector {|x| x.even? }.take(10)
  # While `select' returns an array, `selector' returns an Enumerator
  # corresponding the array.  So, the latter requires no intermediate
  # array, which makes the latter more effective than the former.


  # Sieve of Eratosthenes
  def sieve(e, &blk)
    yield n = e.first
    sieve(e.rejecter {|x| x % n == 0 }, &blk)
  end

  sieve(2..(1.0/0.0)) {|x| p x } #=> 2, 3, 5, 7, 11, 13, 17, 19, 23, ...


  # Fibonacci numbers
  def fibonacci
    Enumerator.new do |e|
      e << 1
      e << 1
      fibonacci.zip(fibonacci.dropper(1)) {|x, y| e << x + y }
    end
  end

  fibonacci.each {|x| p x } #=> 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

== REQUIREMENTS:

None

== INSTALL:

* gem install enumerabler

== LICENSE:

Copyright:: Yusuke Endoh <mame@tsg.ne.jp>
License:: Ruby's
