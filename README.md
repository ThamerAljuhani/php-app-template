# Dockerized PHP-Apache App Template

- Follows best practices in `Dockerfile`, and sets up a working container with a TLS URL behind a Traefik reverse-proxy

**To be used as a template repo**

**The workflow will run on Releases tagged with v.\*.**

## Required Repository Secrets

Make sure to set the following repo secrets:

- [ ] `DOCKERHUB_TOKEN`
- [ ] `DOCKERHUB_USERNAME`
- [ ] `MYSQL_DATABASE`
- [ ] `MYSQL_HOST`
- [ ] `MYSQL_PASSWORD`
- [ ] `MYSQL_USER`
- [ ] `PROJECT_NAME`
- [ ] `SSH_HOST`
- [ ] `SSH_KEY`
- [ ] `SSH_USER`

Proposed File Structure for Vanilla PHP app:

├── app/
│ ├── config/ # DB and environment configs
│ ├── controllers/ # Request handlers
│ ├── models/ # ORM/data access
│ ├── views/ # PHP templates
│ ├── lib/ # Utilities (auth, mailer)
│ └── public/ # Web assets & index.php
│ ├── css/
│ ├── js/
│ └── images/
├── database/ # SQL scripts & migrations
│ └── migrations/
├── docker/ # Docker setup
│ ├── Dockerfile.apache
│ └── docker-compose.yml
├── docs/ # Doc source (SRS, ERDs)
├── tests/ # Unit/integration tests
├── vendor/ # Composer deps
└── README.md # Overview & setup
