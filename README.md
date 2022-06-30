Docker-Mailserver with support of relay hosts
=================

Docker Mailserver is a fork of [Jeboehm Docker Mailserver](https://github.com/jeboehm/docker-mailserver) project.
Docker Mailserver is great project to server producttion mail server on your host! It's based on the famous [ISPMail guide](https://workaround.org/ispmail/) and all images based on [Alpine Linux](https://alpinelinux.org). It's so small as possible :)

Build status
------------
[![Integration Tests](https://github.com/TopTuK/docker-mailserver/actions/workflows/integration-tests.yml/badge.svg)](https://github.com/TopTuK/docker-mailserver/actions/workflows/integration-tests.yml)
[![Lint Dockerfiles](https://github.com/TopTuK/docker-mailserver/actions/workflows/lint-dockerfile.yml/badge.svg)](https://github.com/TopTuK/docker-mailserver/actions/workflows/lint-dockerfile.yml)
[![Lint YAMLs](https://github.com/TopTuK/docker-mailserver/actions/workflows/lint-yaml.yml/badge.svg)](https://github.com/TopTuK/docker-mailserver/actions/workflows/lint-yaml.yml)

Features
--------
- POP3, IMAP, SMTP with user authentication
- TLS enforced
- Webmail interface
- Server-side mail filtering, rule configuration via web frontend
- Spam- and malware filter
- Catchall address support
- Restricted sender addresses
- Spamfilter is trained just by moving emails to or out of the junk folder
- Uses RBL (real time black hole lists) to block already known spam senders
- Greylisting only when incoming mail is likely spam
- DKIM message signing
- Quota support
- Notifications when exceeding the quota
- Web management interface to create / remove accounts, domains and aliases
- Support of send only accounts which are not allowed to receive but send mails
- IMAP, POP3 and malware filters can be disabled if they are not used
- FTS (Full-Text Search) support using [fts-xapian](https://github.com/grosjo/fts-xapian) for fast message searching
- Permanent self testing by Docker's healthcheck feature
- Developed with high quality assurance standards
- Address extension (-)

Simple installation
--------
1. Run git clone https://github.com/TopTuK/docker-mailserver.git
2. Copy the file .env.dist to .env and change the variables in it according to your needs.
3. Run ./bin/production.sh pull to download the images.
4. Run ./bin/production.sh build to build images.
5. Run bin/production.sh up -d to start the services. After a few seconds you can access the services.
6. Create your first email address and an admin user by running bin/production.sh run --rm web setup.sh. The wizard will ask you a few questions to set everything up.

Now you can login to the management interface with your new account credentials.

[RU]
- Описание простой настройки: [ссылка](https://teletype.in/@toptuk/8IqqNLs9dst)