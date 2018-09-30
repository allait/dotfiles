if which gpg-agent >/dev/null; then
  if ! pgrep gpg-agent >/dev/null; then
    gpg-agent --quiet --daemon 2>/dev/null
  fi
  if [ -f "${GPG_ENV_FILE}" ]; then
    source "${GPG_ENV_FILE}"
    export GPG_AGENT_INFO
  fi
fi
