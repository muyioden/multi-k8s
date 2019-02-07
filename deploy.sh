docker build -t muyidocker/multi-client:latest -t muyidocker/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t muyidocker/multi-server:latest -t muyidocker/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t muyidocker/multi-worker:latest -t muyidocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker 
docker push muyidocker/multi-client:latest
docker push muyidocker/multi-server:latest
docker push muyidocker/multi-worker:latest


docker push muyidocker/multi-client:$SHA
docker push muyidocker/multi-server:$SHA
docker push muyidocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=muyidocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=muyidocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=muyidocker/multi-worker:$SHA