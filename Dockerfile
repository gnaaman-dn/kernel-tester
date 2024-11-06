FROM ubuntu:24.04
RUN apt update
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt install --yes git qemu-kvm udev iproute2 busybox-static \
     coreutils python3-requests python3-argcomplete libvirt-clients kbd kmod file rsync zstd virtiofsd \
     gcc-multilib libc6-i386 libc6-dev-i386 libnuma-dev libcap-dev bc flex bison libelf-dev make gcc clang \
     ethtool libmnl-dev libfuse-dev virtiofsd net-tools libssl-dev uuid-runtime jq python3-jsonschema socat iptables netsniff-ng netperf tcpdump inetutils-ping libcap-ng-dev
RUN git clone --recursive https://github.com/arighi/virtme-ng.git
RUN echo 'export PATH="$PATH:/virtme-ng"' >> ~/.bashrc
RUN usermod -a -G kvm root

RUN echo 'vng --build  --config tools/testing/selftests/net/config --config kernel/configs/debug.config' >> /root/.bash_history
RUN echo 'vng -v --run . --user root --cpus 4 -- make -C tools/testing/selftests TARGETS=net run_tests' >> /root/.bash_history
RUN echo 'make headers && make -C tools/testing/selftests/ TARGETS=net' >> /root/.bash_history
WORKDIR /kernel
ENTRYPOINT bash
