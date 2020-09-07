
docker build . -t us.gcr.io/kuber-276115/snappass:v2.0.0
gcloud auth configure-docker
docker push us.gcr.io/kuber-276115/snappass:v2.0.0