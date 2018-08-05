
```angular2html
docker build -t loadscript-locust .
docker login
docker tag 9cfa649cb82a vignesh97/loadscript-locust:latest
docker push vignesh97/loadscript-locust:latest
```