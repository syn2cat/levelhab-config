Installing proxy for paperUI
sudo bash
apt-get update
apt-get install nginx

rm /etc/nginx/sites-enabled/default
cat >/etc/nginx/sites-available/openhab <<"EOF"
server {
    listen          80;
    server_name     lights.level2.lu;

    location / {
        proxy_pass                            http://localhost:8080/basicui/;
        proxy_set_header Host                 $http_host;
        proxy_set_header X-Real-IP            $remote_addr;
        proxy_set_header X-Forwarded-For      $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto    $scheme;
    }
}
EOF
ln -s /etc/nginx/sites-available/openhab /etc/nginx/sites-enabled/
service nginx restart
