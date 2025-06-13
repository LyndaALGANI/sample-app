#!/usr/bin/env bash
mkdir -p tempdir/{templates,static}
cp sample_app.py tempdir/
cp templates/*    tempdir/templates/
cp static/*       tempdir/static/

cat <<EOF > tempdir/Dockerfile
FROM python
RUN pip install flask
COPY ./static /home/myapp/static/
COPY ./templates /home/myapp/templates/
COPY sample_app.py /home/myapp/
EXPOSE 8080
CMD python3 /home/myapp/sample_app.py
EOF

cd tempdir
docker build -t sampleapp .
docker run -d -p 8080:8080 --name samplerunning sampleapp
docker ps -a
