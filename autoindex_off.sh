docker exec ft_server rm /etc/nginx/sites-available/server.conf
docker cp srcs/server_autoindex_off.conf ft_server:/etc/nginx/sites-available/server.conf
docker exec ft_server service nginx reload
