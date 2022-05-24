FROM 582055102416.dkr.ecr.eu-central-1.amazonaws.com/alpine:3.5
RUN apk add --update py2-pip  && \
    pip install --upgrade pip  && \
    apk --no-cache add curl
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt
COPY app.py /usr/src/app/
COPY  start.sh /usr/src/app/
RUN chmod +x /usr/src/app/start.sh
COPY templates/index.html /usr/src/app/templates/
EXPOSE 5000
CMD ["/usr/src/app/start.sh"]
