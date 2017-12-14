FROM microsoft/aspnetcore:2.0

MAINTAINER 装睡的人

RUN apt-get update && \
    apt-get install -y libgdiplus && \
    ln -s /usr/lib/libgdiplus.so /usr/lib/gdiplus.dll && \
    rm -rf /var/lib/apt/lists/*

VOLUME ["/app"]

WORKDIR /app

ENTRYPOINT ["dotnet"]
