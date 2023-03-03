FROM python:3.10-alpine

# Install any needed dependencies...
# RUN go get ...

# Set the working directory
WORKDIR /usr/src

RUN pip install --upgrade pip

# Copy the requirements file into the container
COPY ./requirements.txt /usr/src

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Copy the current directory contents into the container at /usr/src
COPY . /usr/src

# Set environment variables for MySQL connection
ENV MYSQL_DATABASE=minitwit
ENV MYSQL_USER=root
ENV MYSQL_PASSWORD=root
ENV MYSQL_HOST=localhost
ENV MYSQL_PORT=3606

# Install the MySQL client and configure the Django app to use MySQL
# Install dependencies
RUN apk update && \
    apk add build-base mariadb-connector-c-dev && \
    pip install mysqlclient

# Make port 8080 available to the host
EXPOSE 8000

# RUN python manage.py migrate

# Build and run the server when the container is started
CMD ["sh", "-c", "DJANGO_SETTINGS_MODULE=ITU_MiniTwit.settings python manage.py runserver 0.0.0.0:8000"]

