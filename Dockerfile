FROM ghcr.io/missemily2022/remotesheller:dev

# Copies config(if it exists)
COPY . .

# Install requirements and start the bot
RUN npm install --force

#install requirements
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# setup workdir
COPY nginx.conf /etc/nginx/nginx.conf
RUN dpkg --add-architecture i386 && apt-get update && apt-get -y dist-upgrade

CMD /bin/bash -c "envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon on;' && cd /usr/src/app && mkdir Downloads && bash start.sh
