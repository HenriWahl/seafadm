FROM python:2

LABEL maintainer=h.wahl@ifw-dresden.de

ARG HTTP_PROXY=''

RUN pip install --proxy $HTTP_PROXY beautifulsoup4 psutil requests

WORKDIR /seafadm