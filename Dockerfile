FROM ubuntu:22.04

# تثبيت الأدوات الأساسية وإدارة اتصالات الشبكة
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    tar \
    iptables \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# تحميل ملفات تيتان الرسمية المخصصة لبيئات Linux المعزولة
RUN wget https://github.com/TitanNet-DAO/titan-node/releases/download/v0.1.18/titan-edge_v0.1.18_linux_amd64.tar.gz \
    && tar -zxvf titan-edge_v0.1.18_linux_amd64.tar.gz \
    && mv titan-edge_v0.1.18_linux_amd64/* . \
    && rm -rf titan-edge_v0.1.18_linux_amd64*

# المنفذ القياسي المطلوب للحفاظ على استقرار الحاويات السحابية
EXPOSE 7860

# سكربت الإقلاع وحقن المفتاح المصحح (ILp4RBFfu0UE)
RUN echo '#!/bin/sh\n\
while true; do echo -e "HTTP/1.1 200 OK\\r\\n\\r\\n OK" | nc -l -p 7860; done &\n\
./titan-edge daemon start --init &\n\
sleep 5\n\
./titan-edge bind --hash=ILp4RBFfu0UE\n\
wait\n\
' > start.sh

RUN chmod +x start.sh

CMD ["/start.sh"]
