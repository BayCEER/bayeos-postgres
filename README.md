# BayEOS PostgreSQL Image

PostgreSQL 17 image for the BayEOS stack. It extends the official PostgreSQL
image with the components required by `bayeos-gateway`:

- PL/Perl (`plperl` and `plperlu`)
- Perl `Math::Spline`, used by the gateway's spline interpolation functions
- An initialization script that creates a second database for the gateway

The image is intended for use with
[bayeos-compose](https://github.com/BayCEER/bayeos-compose).

## Initialization and Persistence

The gateway database and role are created by
`/docker-entrypoint-initdb.d/01-second-db.sh`. PostgreSQL runs initialization
scripts only when `/var/lib/postgresql/data` is empty.

## Docker Compose

The BayEOS Compose deployment selects the image through
`BAYEOS_POSTGRES_IMAGE`:

## Building Locally

From this directory:

```sh
docker build -t bayeos-postgres:local .
```

The Dockerfile is based on `postgres:17`; keep the installed
`postgresql-plperl-17` package aligned with the PostgreSQL major version when
changing the base image.

## Publishing

The GitHub Actions workflow at
[.github/workflows/docker-publish.yml](.github/workflows/docker-publish.yml)
publishes on pushes to `main`, version tags (`v*`), or manual dispatch. Set
these repository values in GitHub Actions:

- Secret `DOCKERHUB_USERNAME`
- Secret `DOCKERHUB_TOKEN`
- Variable `DOCKERHUB_REPOSITORY`, for example `bayceer/bayeos-postgres`
