# BayEOS PostgreSQL: official image + PL/Perl and the Perl Math::Spline module.
#
# The gateway schema needs both:
#   - plperl/plperlu  -> functions init_spline()/real_value() (V1.99, V2.50, V2.97)
#   - Math::Spline   -> spline interpolation used by real_value()
# real_value() is called from the gateway REST layer (BoardRestController).
#
# The Debian-based official images install PostgreSQL from apt.postgresql.org,
# so postgresql-plperl-<major> matches the server version exactly.
FROM postgres:17

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		postgresql-plperl-17 \
		libmath-spline-perl \
	; \
	rm -rf /var/lib/apt/lists/*

# Gateway "dual instance" database creation, runs on first init of the data volume.
# In the dev stack the same directory is bind-mounted over this path.
COPY init/ /docker-entrypoint-initdb.d/
