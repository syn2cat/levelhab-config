An openHAB implementaiton for the level2 hackerspace

Dump this into /etc/openhab2





Installing proxy for paperUI

sudo bash
apt-get update
apt-get install nginx

rm /etc/nginx/sites-enabled/default
cat >/etc/nginx/sites-available/openhab <<"EOF"
server {
    listen          80;
    server_name     lights.level2.lu;
# https://community.openhab.org/t/occasional-offline-in-basicui-when-proxying-via-nginx-connection-timed-out/63347
    location / {
        proxy_pass                            http://localhost:8080/;
            proxy_buffering                 off;
            proxy_request_buffering         off;
            proxy_http_version              1.1;
        proxy_set_header Host                 $http_host;
        proxy_set_header X-Real-IP            $remote_addr;
        proxy_set_header X-Forwarded-For      $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto    $scheme;
        proxy_set_header X-Forwarded-Host $host:$server_port;
        proxy_set_header X-Forwarded-Server $host;
            client_body_buffer_size         0;
            client_max_body_size            0;
            proxy_max_temp_file_size        0;
            proxy_read_timeout              18000;
            proxy_send_timeout              18000;

            gzip                            off;
    }
    location ~ ^/(paperui|habmin) {
        # return 301 /basicui/app;
        deny all;
    }
}
EOF
ln -s /etc/nginx/sites-available/openhab /etc/nginx/sites-enabled/
service nginx restart
