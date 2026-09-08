# n8n Production

Self-hosted n8n deployment using:

- Docker Compose
- PostgreSQL
- Cloudflare Tunnel

## Architecture

```text
Internet
   |
   v
n8n.slasdevelopments.com
   |
   v
Cloudflare
   |
   v
Cloudflare Tunnel
   |
   v
n8n:5678
   |
   v
PostgreSQL:5432