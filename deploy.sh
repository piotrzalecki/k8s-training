docker build -t piotrzalecki/multi-client:latest -t piotrzalecki/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t piotrzalecki/multi-server:latest -t piotrzalecki/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t piotrzalecki/multi-worker:latest -t piotrzalecki/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push piotrzalecki/multi-client:latest
docker push piotrzalecki/multi-server:latest
docker push piotrzalecki/multi-worker:latest

docker push piotrzalecki/multi-client:$SHA
docker push piotrzalecki/multi-server:$SHA
docker push piotrzalecki/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deplomyents/server-deployment server=piotrzalecki/multi-client:$SHA
kubectl set image deployments/client-deployment client=piotrzalecki/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=piotrzalecki/multi-worker:$SHA
