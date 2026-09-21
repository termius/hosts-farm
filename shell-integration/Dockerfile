FROM ubuntu:26.04

RUN apt-get update -y && apt-get install -y locales && \
  locale-gen en_US.UTF-8 && update-locale LC_ALL="en_US.UTF-8"
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y && \
  apt-get install -y openssh-server gettext-base syslog-ng \
    vttest tmux byobu emacs vim mc htop curl nano \
    bb cmatrix libaa-bin \
    zsh git

# Ghostty shell integration (OSC 133 prompt marks, cursor and title reporting).
# Both files must land in the same directory: ghostty.bash resolves bash-preexec.sh
# relative to its own path.
ARG GHOSTTY_REF=e31615d00bf3811bdba4ae697c80fcb1ede3817a
ARG GHOSTTY_RAW=https://raw.githubusercontent.com/ghostty-org/ghostty/${GHOSTTY_REF}/src/shell-integration/bash
ADD shell-integration/bashrc /tmp/ghostty-bashrc
RUN mkdir -p /etc/ghostty-shell-integration/bash && \
  curl -fsSL -o /etc/ghostty-shell-integration/bash/ghostty.bash "${GHOSTTY_RAW}/ghostty.bash" && \
  curl -fsSL -o /etc/ghostty-shell-integration/bash/bash-preexec.sh "${GHOSTTY_RAW}/bash-preexec.sh" && \
  cat /tmp/ghostty-bashrc >> /etc/bash.bashrc

# The whole point of this host is emitting OSC 133, and a host that fails to load the
# integration still boots and accepts logins. Fail the build instead.
RUN bash -lic 'declare -F __ghostty_precmd >/dev/null' \
  || { echo "FATAL: ghostty shell integration did not load in an interactive login shell" >&2; exit 1; }

ADD shell-integration/entrypoint.sh /usr/bin/entrypoint.sh
ADD shell-integration/sshd_config /tmp/
ADD keys /tmp/
ADD zshrc /tmp/

RUN chmod +x /usr/bin/entrypoint.sh
CMD /usr/bin/entrypoint.sh
