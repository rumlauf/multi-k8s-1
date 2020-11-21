docker build -t rumlauf/multi-client:latest -t rumlauf/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rumlauf/multi-server:latest -t rumlauf/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rumlauf/multi-worker:latest -t rumlauf/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rumlauf/multi-client:latest
docker push rumlauf/multi-server:latest
docker push rumlauf/multi-worker:latest

docker push rumlauf/multi-client:$SHA
docker push rumlauf/multi-server:$SHA
docker push rumlauf/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rumlauf/multi-server:$SHA
kubectl set image deployments/client-deployment client=rumlauf/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rumlauf/multi-worker:$SHA