all:
	@echo "Available:"
	@echo "make test"
	@echo "make testloop"

test:
	green tests/ --quiet-stdout
	autopep8 --diff -r . | colordiff
	autopep8 --diff -r tests/ | colordiff
	flake8 tests/ setup.py duden.py common.py

testloop:
	while inotifywait -q -r -e modify --exclude .git .; do \
		clear; make test; \
	done

clean:
	rm -rf __pycache__ tests/__pycache__
