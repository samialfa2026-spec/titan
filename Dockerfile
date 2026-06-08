FROM ubuntu:22.04

# تثبيت الحزم الأساسية
RUN apt-get update && \
    apt-get install -y wget tar ca-certificates curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# تحميل الإصدار الرسمي من شبكة Titan وتجهيز الملفات
RUN wget -q https://github.com/Titannet-dao/titan-node/releases/download/v0.1.20/titan-edge_v0.1.20_246b9dd_linux-amd64.tar.gz && \
    tar -xzf titan-edge_v0.1.20_246b9dd_linux-amd64.tar.gz && \
    mv titan-edge_v0.1.20_246b9dd_linux-amd64/titan-edge . && \
    mv titan-edge_v0.1.20_246b9dd_linux-amd64/libgoworkerd.so /usr/lib/ && \
    rm -rf titan-edge_v0.1.20_246b9dd_linux-amd64*

# ضبط مكتبة الارتباط (مهم جداً لتشغيل العقدة)
ENV LD_LIBRARY_PATH="/usr/lib:${LD_LIBRARY_PATH}"

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# نقطة التشغيل التلقائية
CMD ["/app/start.sh"]
