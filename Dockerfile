# syntax = docker/dockerfile:1.0-experimental
FROM archlinux/base:latest

WORKDIR /usr/src/report

RUN pacman -Syu --noconfirm pandoc texlive-latexextra texlive-fontsextra texlive-bin nodejs yarn

COPY package*.json ./

COPY gulpfile*.js ./

RUN yarn install

COPY ./resources/eisvogel.latex /usr/share/pandoc/data/templates/

RUN mkdir {src,generated}

COPY ./src/*.md ./src/

USER nobody

CMD ["/usr/bin/node", "./node_modules/gulp/bin/gulp.js", "build"]
