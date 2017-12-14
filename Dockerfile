FROM centos:7

MAINTAINER 装睡的人
RUN mkdir /app && mkdir /tmp/net_core
VOLUME ["/app"]

WORKDIR /tmp/net_core

#RUN echo 安装.net core 2.0 依赖的组件

RUN echo 安装.net core 2.0 依赖的组件 && \
    yum install deltarpm epel-release unzip libunwind gettext libcurl-devel openssl-devel zlib libicu-devel  make which -y && \
    echo 安装.net core 2.0 && \
    curl -sSL -o dotnet.tar.gz https://aka.ms/dotnet-sdk-2.0.0-linux-x64 &&  mkdir -p /opt/dotnet && tar -zxf dotnet.tar.gz -C /opt/dotnet && \
    ln -s /opt/dotnet/dotnet /usr/local/bin && \
    echo install gdiplus && \
    yum install autoconf automake libtool -y && \
    yum install freetype-devel fontconfig ttmkfdir libXft-devel -y && \
    yum install libjpeg-turbo-devel libpng-devel giflib-devel libtiff-devel libexif-devel -y && \
    yum install glib2-devel cairo-devel -y && \
    curl -sSL -o libgdiplus-master.zip https://codeload.github.com/mono/libgdiplus/zip/master && unzip libgdiplus-master.zip && \
    echo install fonts && \
    curl -sSL -o fonts-master.zip https://codeload.github.com/CocoaFaith/fonts/zip/master && unzip fonts-master.zip && cp -r fonts-master/* /usr/share/fonts && ttmkfdir -e /usr/share/X11/fonts/encodings/encodings.dir && fc-cache

WORKDIR /tmp/net_core/libgdiplus-master

RUN ./autogen.sh && make &&  make install

WORKDIR /usr/lib64/

RUN ln -s /usr/local/lib/libgdiplus.so gdiplus.dll && \
    rm -fr /tmp/net_core && \
    yum remove unzip make which ttmkfdir -y

WORKDIR /app

ENTRYPOINT ["dotnet"]
