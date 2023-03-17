# Flask Sample App
- [Flask Sample App](#flask-sample-app)
  - [Pre-requisite](#pre-requisite)
  - [Architecture \& Command lines](#architecture--command-lines)
  - [Configuration](#configuration)
  - [Endpoints](#endpoints)
  - [To Do \& Questions](#to-do--questions)
    - [Build](#build)
    - [Deployment](#deployment)

## Pre-requisite

To run locally application, install `docker` and `docker compose`.

Run `docker compose up -d` to start app.

Check the following endpoints:
```console
$ curl localhost:8080/-/healthy -w "%{http_code}"
{}
200
$ curl localhost:8080/-/ready -w "%{http_code}"
{}
200
$ curl localhost:8080/user -w "%{http_code}"
[...]
200
```

## Architecture & Command lines

Application is made of:
* a Web Server for API Calls. The web server can be started with `flask run --host 0.0.0.0 --port 8080`
* migration script to confugure the database. The migration script can be run with `flask db upgrade`

Application needs a PostgreSQL database to run.

## Configuration

The following environment variable allow to configure application:
* `POSTGRES_USERNAME`: username of PostgreSQL
* `POSTGRES_PASSWORD`: password of PostgreSQL
* `POSTGRES_HOST`: hostname or IP of PostgreSQL
* `POSTGRES_PORT`: listening port of PostgreSQL
* `POSTGRES_DATABASE`: name of the database

## Endpoints

The following endpoints are available
* `GET localhost:8080/-/healthy`: return `200` when server is up
* `GET localhost:8080/-/ready`: return `200` when server is up
* `GET localhost:8080/user`: return list of users in database
* `POST localhost:8080/user`: create a user in database. The request must contain a body: `{'username': 'my_username', 'email': 'my_email'}`

## To Do & Questions

### Build

* Create a GitLab CI pipeline that build the docker image.
* Suggest improvement of this pipeline.
* Suggest optimizations on the Dockerfile

### Deployment

* Create Helm chart templates to deploy application
  * A minimum of 2 pods are required for web server
  * don't forget to run migration scripts at deployment
  * After installation, the endpoint `/user` works well.
* Are liveness & readiness probes correctly implemented? Why?
* What improvement can be done in your Helm Chart?
