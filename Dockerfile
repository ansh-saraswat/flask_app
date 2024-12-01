FROM python:3.10
WORKDIR /app


RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN pip install mysqlclient

COPY requirements.txt .
RUN python3 -m pip install --upgrade pip \
&& pip install --no-cache-dir -r requirements.txt

//RUN apt-get install -y wget
//RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -O /usr/local/bin/wait-for-it
//RUN chmod +x /usr/local/bin/wait-for-it

COPY . . 
EXPOSE 5000
//CMD ["wait-for-it", "db:3306", "--", "flask", "run", "--host=0.0.0.0", "--port=5000"]
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]