#!/bin/sh

#Config xray

rm -rf /etc/xray/config.json
cat << EOF > /etc/xray/config.json
{
  "inbounds": [
    {
      "port": $PORT,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "$UUID",
            "level": 0
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "alpn": "http/1.1",
            "dest": 80
          },
          {
            "alpn": "h2",
            "dest": 81
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "tls",
        "tlsSettings": {
          "serverName": "viettel.akamaized.net",
          "alpn": ["http/1.1", "h2"]
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
EOF

#run xray

xray -c /etc/xray/config.json
