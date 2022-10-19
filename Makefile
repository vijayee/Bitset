build:
	mkdir -p build
test: build
	mkdir -p build/test
test/Bitset: test Bitset/test/*.pony
	corral fetch
	corral run -- ponyc Bitset/test -o build/test --debug
test/execute: test/Bitset
	./build/test/test --sequential
clean:
	rm -rf build

.PHONY: clean test
