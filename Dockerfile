FROM php:7.4-cli

LABEL "com.github.actions.name"="GA-PHPLint"
LABEL "com.github.actions.description"="Run PHP linter on PR"
LABEL "com.github.actions.icon"="aperture"
LABEL "com.github.actions.color"="blue"

LABEL version="0.0.1"
LABEL repository="https://github.com/justia/ga-phplint-7.4"
LABEL homepage="https://github.com/justia/ga-phplint-7.4"

RUN apt-get update && apt-get -y install zip unzip && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- \
--install-dir=/usr/bin --filename=composer && chmod +x /usr/bin/composer

RUN mkdir /phplint && cd /phplint && composer require overtrue/phplint && ln -s /phplint/vendor/bin/phplint /usr/local/bin/phplint

COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
