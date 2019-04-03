docker build -t mkabdulsalam/multi-client:latest -t mkabdulsalam/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t mkabdulsalam/multi-server:latest -t mkabdulsalam/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t mkabdulsalam/multi-worker:latest -t mkabdulsalam/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker
docker push mkabdulsalam/multi-client:latest
docker push mkabdulsalam/multi-server:latest
docker push mkabdulsalam/multi-worker:latest

docker push mkabdulsalam/multi-client:$SHA
docker push mkabdulsalam/multi-server:$SHA
docker push mkabdulsalam/multi-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployment/server-deployment server=mkabdulsalam/multi-server:$SHA
kubectl set image deployment/client-deployment client=mkabdulsalam/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=mkabdulsalam/multi-worker:$SHA
