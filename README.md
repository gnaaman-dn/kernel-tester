# Kernel Tester

Probably not enough to run entire suite of tests, but good enough for most network tests.

Example for running network tests:
```
$ docker build -t kernel-tester .

$ cd /path/to/kernel
$ docker run -it --privileged --name kernel-tester -v $(pwd):/kernel kernel-tester /bin/bash

# vng --build  --config tools/testing/selftests/net/config --config kernel/configs/debug.config
# make headers && make -C tools/testing/selftests/ TARGETS=net
# vng -v --run . --user root --cpus 4 -- make -C tools/testing/selftests TARGETS=net run_tests
```
