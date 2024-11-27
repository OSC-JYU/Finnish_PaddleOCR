FROM python:3.9

RUN useradd -m -u 1000 user

WORKDIR /usr/src/app
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
COPY requirements_cpu.txt ./

RUN pip install --upgrade pip
RUN pip install --no-cache-dir --upgrade -r requirements_cpu.txt

USER user
COPY --chown=1000 ./ /usr/src/app

#CMD [ "python", "./api.py" ]
CMD ["uvicorn",  "api_onnx:app",  "--host",  "0.0.0.0",  "--port", "8800"]

