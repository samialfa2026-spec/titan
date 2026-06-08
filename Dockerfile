FROM nezha123/titan-edge:latest

USER root
# تحديث الشهادات لتجنب أخطاء الاتصال بالخوادم
RUN apt-get update && apt-get install -y ca-certificates bash curl && rm -rf /var/lib/apt/lists/*

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/bin/bash", "/start.sh"]
