FROM httpd:2.4.25-alpine
MAINTAINER Pierre Beitz <pibeitz@gmail.com>

COPY ./dist/ /usr/local/apache2/htdocs/