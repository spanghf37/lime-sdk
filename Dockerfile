FROM debian:latest

RUN apt-get update && apt-get install subversion build-essential libncurses5-dev zlib1g-dev gawk git ccache gettext libssl-dev xsltproc wget unzip python time wget -y

RUN useradd -ms /bin/bash builder

USER builder

WORKDIR /home/builder

RUN git clone https://git.openwrt.org/openwrt/openwrt.git

RUN cd openwrt && git pull

RUN cd openwrt && git clone https://github.com/cuihaoleo/lede-mr-mips target/linux/mr-mips

RUN git clone https://github.com/spanghf37/lime-sdk.git

#RUN wget https://downloads.openwrt.org/releases/17.01.4/targets/ar71xx/generic/lede-imagebuilder-17.01.4-ar71xx-generic.Linux-x86_64.tar.xz

#RUN wget https://downloads.openwrt.org/releases/17.01.4/targets/ar71xx/generic/lede-sdk-17.01.4-ar71xx-generic_gcc-5.4.0_musl-1.1.16.Linux-x86_64.tar.xz

#RUN cd openwrt && make defconfig && cat .config

#RUN cd openwrt && cp target/linux/mr-mips/misc/lede-config .config

RUN cp .config openwrt && cd openwrt && make defconfig && make -j1 V=s && ls

#RUN ./cooker -f

#RUN ./cooker -i ar71xx/generic --ib-file=lede-imagebuilder-17.01.4-ar71xx-generic.Linux-x86_64.tar.xz --sdk-file=lede-sdk-17.01.4-ar71xx-generic_gcc-5.4.0_musl-1.1.16.Linux-x86_64.tar.xz

#RUN ./cooker -b ar71xx/generic --force-local

#RUN ./cooker -c ar71xx/generic --profile=ubnt-unifiac-pro --flavor=lime_mini --community=mesh/generic --force-local

ENTRYPOINT ["/home/builder/cooker"]

CMD ["--help"]
