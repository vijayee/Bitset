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
