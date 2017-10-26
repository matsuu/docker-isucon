FROM python:3.6.2

ARG GIT_URL=https://github.com/isucon/isucon7-qualify.git

RUN git clone $GIT_URL /home/isucon/isubata
WORKDIR /home/isucon/isubata/webapp/python
RUN pip install -r requirements.txt

EXPOSE 5000

ENTRYPOINT ["gunicorn", "app:app", "-b", "0.0.0.0:5000"]
CMD ["--workers=4", "--threads=4"]
