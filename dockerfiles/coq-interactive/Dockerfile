# Coq 8.18.0

FROM coqorg/coq:8.18.0

RUN sudo apt update && sudo apt install -y adwaita-icon-theme libcairo2-dev libexpat1-dev libgtk-3-dev libgtksourceview-3.0-dev

# Install coqide
RUN opam update
RUN opam install -y coqide
