FROM debian:latest

RUN apt-get update && apt-get install subversion build-essential libncurses5-dev zlib1g-dev gawk git ccache gettext libssl-dev xsltproc wget unzip python time -y

ADD . /app

WORKDIR /app

RUN git clone https://github.com/spanghf37/lime-sdk.git

RUN ./cooker -c ar71xx/generic --profile=ubnt-unifiac-pro --flavor=lime_default --community=mesh/generic

ENTRYPOINT ["/app/cooker"]
CMD ["--help"]
