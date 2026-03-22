# N8N Railway v2 - Daily Health Operations

## Stack
- **N8N v2.12.2** (versão fixa, atualização controlada)
- **Deploy**: Railway via Dockerfile
- **Timezone**: America/Sao_Paulo

## Workflows
| Workflow | Webhook | Função |
|----------|---------|--------|
| Ingest \| Queue Operation | `/v3` | Recebe postback Payt, normaliza, enfileira |
| Ingest \| Report Daily Health | `/ingest` | Registra vendas na planilha de relatório |
| Process \| Operation | `/processador-fila` | Core: processa fila, envia WhatsApp, adiciona grupos |
| Fallback \| Operation | `/fallback` | Fallback do processamento principal |
| SUB_Validação_Numero | Sub-workflow | Valida número via Baileys |
| Ingest \| Conversas Suporte | `/mensagens-recebidas` | Recebe mensagens do buffer Baileys |
| Ingest \| Conversas Unnichat | `/ingest_unnichat` | Ingesta conversas do Unnichat |

## Integrações
- **Baileys (WhatsApp)**: `railwaywhatsv3-production.up.railway.app`
- **Baileys Juliana (Zero Lipedema)**: `railwaywhatsv3-juliana-production.up.railway.app`
- **Payt**: Gateway de pagamento (postbacks)
- **Unnichat**: Captação/nutrição de leads pré-venda
- **Hotwebinar**: Webinário diário de conversão
- **Google Sheets**: Fila, logs, relatórios

## Funil
```
AD → Unnichat (lead) → Hotwebinar (conversão) → Payt (checkout) → WhatsApp/Baileys (onboarding)
```

## Deploy
1. Crie novo serviço no Railway apontando para este repo
2. Configure as variáveis de ambiente (ver `.env.example`)
3. Importe os workflows via N8N UI
4. Reconfigure credenciais (Google Sheets)
5. Ajuste URLs dos webhooks nos workflows
6. Redirecione postbacks da Payt e WEBHOOK_URL do Baileys

## Atualização
Para atualizar o N8N, altere a versão no `Dockerfile`:
```dockerfile
FROM n8nio/n8n:X.Y.Z
```
Commit e o Railway faz redeploy automático.

## Diferenças vs v1
| | v1 (n8n-railway) | v2 (n8n-railway-v2) |
|---|---|---|
| Versão N8N | `latest` (desatualizado) | `2.12.2` (fixa) |
| Timezone | Não configurado | America/Sao_Paulo |
| Prune executions | Não | Sim (7 dias) |
| Healthcheck | Básico | Com retries e timeout |
| Docs | Nenhum | README + .env.example |
