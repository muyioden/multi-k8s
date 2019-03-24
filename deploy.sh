docker build -t muyidocker/multi-client:latest -t muyidocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t muyidocker/multi-server:latest -t muyidocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t muyidocker/multi-worker:latest -t muyidocker/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push muyidocker/multi-client
docker push muyidocker/multi-server
docker push muyidocker/multi-worker

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=muyidocker/server