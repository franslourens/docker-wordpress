docker build -t franslourens/php-wordpress:latest -t franslourens/php-wordpress:$SHA -f Dockerfile.php .
docker build -t franslourens/nginx-wordpress:latest -t franslourens/nginx-wordpress:$SHA -f Dockerfile.nginx .

docker push franslourens/php-wordpress:latest
docker push franslourens/nginx-wordpress:latest

docker push franslourens/php-wordpress:$SHA
docker push franslourens/nginx-wordpress:$SHA

kubectl apply -f k8s/database-persistent-volume-claim.yaml
kubectl apply -f k8s/ingress-service.yaml
kubectl apply -f k8s/mysql-cluster-ip-service.yaml
kubectl apply -f k8s/mysql-deployment.yaml
kubectl apply -f k8s/wordpress-cluster-ip-service.yaml
kubectl apply -f k8s/wordpress-deployment.yaml
kubectl apply -f k8s/memcache-cluster-ip-service.yaml
kubectl apply -f k8s/memcache-deployment.yaml

kubectl set image deployments/client-deployment fpm=franslourens/php-wordpress:$SHA
