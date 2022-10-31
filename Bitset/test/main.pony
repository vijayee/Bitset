use "pony_test"
use ".."

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)
  new make () =>
    None
  fun tag tests(test: PonyTest) =>
    test(_TestBitset)


class iso _TestBitset is UnitTest
  fun name(): String => "Testing Bitset"
  fun apply(t: TestHelper) =>
    let bs = Bitset()
    try
      bs(1)? = true
      t.assert_true(bs(1)?)
      bs(1)? = false
      t.assert_false(bs(1)?)
      t.assert_false(bs(1)? = true)
      bs(1)? = false
      for i in bs.values() do
        t.log(i.string())
        t.assert_false(i)
      end
    else
      t.fail("failed to set second bit")
    end
    try
      let bs1 = Bitset(1)
      let bs2 = Bitset(2)
      bs1(0)? = true
      bs1(1)? = false
      bs1(2)? = false
      bs1(3)? = true
      bs1(4)? = false
      bs2(0)? = true
      bs2(1)? = false
      bs2(2)? = false
      bs2(3)? = true
      bs2(4)? = false
      t.log(bs1.string()?)
      t.log(bs2.string()?)
      let bs3: Bitset = bs1 xor bs2
      t.log(bs3.string()?)
      t.assert_true(bs1 == bs2)
      t.assert_true(bs1 != bs3)
    else
      t.fail("failed compare")
    end
