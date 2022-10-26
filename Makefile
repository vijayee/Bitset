prepare:
	mkdir -p build
	mkdir -p build/test
build: prepare Bitset/test/*.pony
	corral fetch
	corral run -- ponyc Bitset/test -o build/test --debug
test: build
	./build/test/test --sequential
clean:
	rm -rf build

.PHONY: clean test
