FROM python:3.12.7-slim
WORKDIR /mfl-server/app
COPY ./requirements.txt /mfl-server/requirements.txt
COPY ./app /mfl-server/app
COPY ./config /mfl-server/config
RUN apt-get update && apt-get install -y --no-install-recommends firefox-esr
RUN pip install --no-cache-dir --upgrade -r /mfl-server/requirements.txt
CMD ["uvicorn", "main:app", "--port", "80", "--host", "0.0.0.0", "--log-config", "/mfl-server/config/log-config.ini"]
