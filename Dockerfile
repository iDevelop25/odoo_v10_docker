FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt update
RUN apt upgrade -y
RUN apt install sudo

#RUN adduser --system --home=/opt/odoo --group odoo
RUN adduser --disabled-password --gecos "Odoo" odoo

# Instalar Node.js y npm desde NodeSource
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@6 && \
    npm install -g less@3.0.4 less-plugin-clean-css



#RUN mkdir /opt/odoo

#WORKDIR /opt/odoo

#COPY src/requirements.txt .

#RUN pip3 install --no-cache-dir -r requirements.txt
RUN apt update

RUN apt-get update && apt-get install -y \
    python2.7 \
    python-pip \
    wget \
    libssl-dev \
    libpq-dev \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libevent-dev \
    libsasl2-dev \
    libldap2-dev \
    libjpeg-dev \
    poppler-utils \
    nano \
    node-clean-css \
    && rm -rf /var/lib/apt/lists/*

RUN apt update
RUN apt-get install -y wget gdebi-core

# Instalar las dependencias de Python a través de pip
RUN pip install \
    Babel==1.3 \
    beautifulsoup4==4.4.1 \
    chardet==2.3.0 \
    cffi==1.14.6 \
    cryptography==1.2.3 \
    decorator==4.0.6 \
    docutils==0.12 \
    enum34==1.1.2 \
    ERPpeek==1.7.1 \
    ebaysdk \
    feedparser==5.1.3 \
    funcsigs==0.4 \
    gdata \
    html5lib==0.999 \
    httplib2==0.9.1 \
    html2text \
    idna==2.0 \
    ipaddress==1.0.16 \
    Jinja2==2.8 \
    lxml==3.5.0 \
    Mako==1.0.3 \
    MarkupSafe==0.23 \
    mock==3.0.5 \
    ndg-httpsclient==0.4.0 \
    passlib==1.6.5 \
    pbr==5.5.1 \
    Pillow==3.1.2 \
    psutil==3.4.2 \
    psycopg2==2.6.1 \
    Python-Chart \
    pyasn1==0.1.9 \
    pydot==1.0.29 \
    Pygments==2.1 \
    pyinotify==0.9.6 \
    pyOpenSSL==0.15.1 \
    pyparsing==2.0.3 \
    pyPdf==1.13 \
    pyserial \
    pysolr==3.3.3 \
    python-dateutil==2.4.2 \
    python-ldap==2.4.22 \
    python-memcached==1.53 \
    python-openid==2.2.5 \
    python-stdnum==1.2 \
    pytz==2023.3 \
    PyYAML==3.11 \
    reportlab==3.3.0 \
    requests==2.9.1 \
    roman==2.0.0 \
    simplejson==3.8.1 \
    six==1.10.0 \
    suds-jurko \
    urllib3==1.13.1 \
    uTidylib==0.9 \
    vatnumber \
    vobject \
    Werkzeug==0.10.4 \
    xlrd==1.0.0 \
    XlsxWriter==0.7.3 \
    xlwt==0.7.5

RUN apt update
RUN apt install default-jre -y


RUN apt-get install libreoffice libreoffice-script-provider-python -y
RUN echo '#!/bin/sh' | tee /etc/init.d/office
RUN echo '/usr/bin/libreoffice --headless --accept="socket,host=localhost,port=8100,tcpNoDelay=1;urp;"&' | tee -a /etc/init.d/office
RUN chmod +x /etc/init.d/office
RUN update-rc.d office defaults
RUN /etc/init.d/office

RUN apt update
RUN apt install unoconv -y

WORKDIR /opt/odoo

RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.xenial_amd64.deb
RUN apt install -f
RUN apt install -y ./wkhtmltox_0.12.6-1.xenial_amd64.deb

RUN apt-get update

RUN apt-get install -y postgresql-client

# Limpiar después de la instalación
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
