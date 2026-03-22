FROM n8nio/n8n:2.12.2

USER root

# Cria diretório do N8N com permissões corretas
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n

# Timezone Brasil
ENV GENERIC_TIMEZONE=America/Sao_Paulo
ENV TZ=America/Sao_Paulo

# Config N8N - usa /home/node/.n8n (diretório padrão do n8n)
ENV N8N_USER_FOLDER=/home/node/.n8n
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
ENV N8N_DIAGNOSTICS_ENABLED=false
ENV N8N_HIRING_BANNER_ENABLED=false
ENV EXECUTIONS_DATA_PRUNE=true
ENV EXECUTIONS_DATA_MAX_AGE=168

USER node

EXPOSE 5678

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:5678/healthz || exit 1

CMD ["n8n", "start"]
