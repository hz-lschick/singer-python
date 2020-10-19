.DEFAULT_GOAL := test

# determine the right python binary
.PYTHON3:=$(shell PATH='$(subst $(CURDIR)/.venv/bin:,,$(PATH))' which python3)

.venv/bin/python:
# if .venv is already a symlink, don't overwrite it
	mkdir -p .venv

# go into the new dir and build it there as venv doesn't work if the target is a symlink
	cd .venv && $(.PYTHON3) -m venv --copies --prompt='[$(shell basename `pwd`)/.venv]' .

# install minimum set of required packages
# wheel needs to be early to be able to build wheels
	.venv/bin/python -m pip install --upgrade pip wheel

check_prereqs: .venv/bin/python
	bash -c '[[ -n $$VIRTUAL_ENV ]]'
	bash -c '[[ $$(python3 --version) == *3.* ]]'

install: check_prereqs
	.venv/bin/python -m pip install -e '.[dev]'

test: install
	pylint singer -d missing-docstring,broad-except,bare-except,too-many-return-statements,too-many-branches,too-many-arguments,no-else-return,too-few-public-methods,fixme,protected-access
	nosetests --with-doctest -v
