test: run
	cat output.txt

run: compile
	./solution input.txt output.txt

compile: clean
	ghc solution.hs

.PHONY: clean
clean:
	rm *.o solution *.hi
