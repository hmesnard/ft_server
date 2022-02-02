docker exec ft_server rm /etc/nginx/sites-available/server.conf
docker cp srcs/server.conf ft_server:/etc/nginx/sites-available/server.conf
docker exec ft_server service nginx reload
