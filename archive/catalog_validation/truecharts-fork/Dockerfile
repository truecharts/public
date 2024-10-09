FROM debian:bookworm

RUN apt-get update

RUN apt-get install -y \
      debhelper-compat \
      dh-python \
      python3-dev \
      python3-setuptools \
      devscripts \
      python3-jsonschema \
      python3-semantic-version \
      python3-kubernetes \
      python3-yaml \
      python3-pip

ENV PYTHONUNBUFFERED 1
ENV WORK_DIR /app
RUN mkdir -p ${WORK_DIR}
WORKDIR ${WORK_DIR}

ADD . ${WORK_DIR}/
RUN pip install --break-system-packages -r requirements.txt
RUN pip install --break-system-packages -U .
