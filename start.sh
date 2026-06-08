#!/bin/bash
echo "Starting Titan Edge Node..."

# تشغيل العقدة في الخلفية
/app/titan-edge daemon start --init --url https://cassini-locator.titannet.io:5000/rpc/v0 &
DAEMON_PID=$!

echo "Waiting 15 seconds for node to initialize..."
sleep 15

# التحقق من وجود رمز التعريف وإجراء الربط
if [ -n "$HASH" ]; then
    echo "Binding node with Identity Code..."
    /app/titan-edge bind --hash=$HASH https://api-test1.container1.titannet.io/api/v2/device/binding
else
    echo "WARNING: HASH environment variable not set! Please add your Identity Code to Railway Variables."
fi

# إبقاء الحاوية قيد التشغيل
wait $DAEMON_PID
