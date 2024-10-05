
FROM python:3.10
WORKDIR /code/model-flight-logbook-server
COPY ./requirements.txt /code/requirements.txt
COPY ./log-config.ini /code/log-config.ini
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
COPY ./model-flight-logbook-server /code/model-flight-logbook-server
CMD ["uvicorn", "main:app", "--port", "80", "--host", "0.0.0.0", "--log-config", "/code/log-config.ini"]
