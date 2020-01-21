# Run VaudTax in a container
## Prerequists
- podman

## How to use
Just clone this repository, ensure you have the prerequists, and run:
```Bash
./run.sh
```

This will build and run a container using ```podman build``` and ```podman run```, and
will start automatically VaudTax application.

## Why?
Because VaudTax doesn't support other Linux than Ubuntu, and there are people on Fedora, CentOS
and other distro. Providing a container is probably the best way to run that app.
