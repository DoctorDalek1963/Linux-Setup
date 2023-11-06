# Coq 8.6.1 with coqide and some common, useful libraries

FROM coqorg/coq:8.6.1
RUN sudo apt update && sudo apt install -y libgdk-pixbuf2.0-0 libgtk2.0-dev libxml2-dev wget

# Download libgtksourceview2.0 packages
RUN wget http://archive.debian.org/debian-archive/debian/pool/main/g/gtksourceview2/libgtksourceview2.0-dev_2.10.5-2_amd64.deb
RUN wget http://archive.debian.org/debian-archive/debian/pool/main/g/gtksourceview2/libgtksourceview2.0-0_2.10.5-2_amd64.deb
RUN wget http://archive.debian.org/debian-archive/debian/pool/main/g/gtksourceview2/libgtksourceview2.0-common_2.10.5-2_all.deb

# Install those packages
RUN sudo dpkg -i libgtksourceview2.0-dev_2.10.5-2_amd64.deb libgtksourceview2.0-0_2.10.5-2_amd64.deb libgtksourceview2.0-common_2.10.5-2_all.deb
RUN rm libgtksourceview2.0-*

# Install coqide
RUN opam update
RUN opam install -y coqide

# Install libraries for Coq
RUN opam install -y coq-geocoq
RUN opam install -y coq-coquelicot
