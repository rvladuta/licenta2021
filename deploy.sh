docker build -t rvladuta/client:latest -t rvladuta/client:$SHA -f ./client/Dockerfile ./client
docker build -t rvladuta/server:latest -t rvladuta/server:$SHA -f ./server/Dockerfile ./server
docker build -t rvladuta/worker:latest -t rvladuta/worker:$SHA -f ./worker/Dockerfile ./worker

docker push rvladuta/client:latest
docker push rvladuta/server:latest
docker push rvladuta/worker:latest

docker push rvladuta/client:$SHA
docker push rvladuta/server:$SHA
docker push rvladuta/worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rvladuta/server:$SHA
kubectl set image deployments/client-deployment client=rvladuta/client:$SHA
kubectl set image deployments/worker-deployment worker=rvladuta/worker:$SHA