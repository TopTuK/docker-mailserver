docker-mailserver with support of relay hosts
=================

Docker Mailserver is a fork of [Jeboehm Docker Mailserver](https://github.com/jeboehm/docker-mailserver) project.
Docker Mailserver is greate project to server producttion mail server on your host! It's based on the famous [ISPMail guide](https://workaround.org/ispmail/) and all images based on [Alpine Linux](https://alpinelinux.org). It's so small as possible :)

Build status
------------
TODO: Make my own build statuses

![Lint YAMLs and Dockerfiles](https://github.com/jeboehm/docker-mailserver/workflows/Lint%20YAMLs%20and%20Dockerfiles/badge.svg)
![Integration Tests](https://github.com/jeboehm/docker-mailserver/workflows/Integration%20Tests/badge.svg)
![Build unofficial-sigs](https://github.com/jeboehm/docker-mailserver/workflows/Build%20unofficial-sigs/badge.svg)

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
