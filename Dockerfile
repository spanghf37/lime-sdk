FROM debian:latest

RUN apt-get update && apt-get install subversion build-essential curl libncurses5-dev zlib1g-dev gawk git ccache gettext libssl-dev xsltproc wget unzip python time wget -y

RUN useradd -ms /bin/bash builder

USER builder

WORKDIR /home/builder

RUN git clone https://github.com/openwrt/openwrt.git

RUN cd openwrt && rm target/linux/ar71xx/files/arch/mips/ath79/machtypes.h && rm target/linux/ar71xx/files/arch/mips/ath79/mach-rb91x.c

RUN cd openwrt/target/linux/ar71xx/files/arch/mips/ath79 && wget https://raw.githubusercontent.com/spanghf37/openwrt/master/target/linux/ar71xx/files/arch/mips/ath79/machtypes.h && wget https://raw.githubusercontent.com/spanghf37/openwrt/master/target/linux/ar71xx/files/arch/mips/ath79/mach-rb91x.c

RUN cd openwrt && cp feeds.conf.default feeds.conf && echo "src-git libremesh https://github.com/libremesh/lime-packages.git" >> feeds.conf && echo "src-git libremap https://github.com/libremap/libremap-agent-openwrt.git" >> feeds.conf && echo "src-git limeui https://github.com/libremesh/lime-ui-ng.git" >> feeds.conf

RUN cd openwrt && scripts/feeds update -a && scripts/feeds install -a

RUN cd openwrt && wget https://raw.githubusercontent.com/spanghf37/lime-sdk/master/.config && make

ENTRYPOINT ["/home/builder/cooker"]

CMD ["--help"]
