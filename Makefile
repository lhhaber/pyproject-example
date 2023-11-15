VENV := venv

setup-venv:
	test -d "${VENV}" || python3 -m venv ${VENV}
	. ${VENV}/bin/activate; pip install -U pip

install: setup-venv ${VENV}
	. ${VENV}/bin/activate; pip install -U .

install-dev: setup-venv ${VENV}
	. ${VENV}/bin/activate; pip install -U -e .[dev]

test:
	. ${VENV}/bin/activate; pytest

format:
	. ${VENV}/bin/activate; black .
	. ${VENV}/bin/activate; isort .

lint:
	. ${VENV}/bin/activate; mypy src/example

clean:
	find . -xdev -depth -mindepth 1 -name "__pycache__" -exec rm -rf {} \;
	find . -xdev -depth -mindepth 1 -name "*.egg-info" -exec rm -rf {} \;
	rm -rf .mypy_cache

.PHONY: setup-venv install install-dev test format lint clean
