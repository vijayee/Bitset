build:
	mkdir -p build
	mkdir -p build/test
test/build: build Bitset/test/*.pony
	corral fetch
	corral run -- ponyc Bitset/test -o build/test --debug
test: test/build
	./build/test/test --sequential
clean:
	rm -rf build

.PHONY: clean test
