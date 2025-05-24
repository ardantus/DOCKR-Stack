# DOCKR-Stack Development Environment made easy

This stack includes:
- Nginx
- PHP (with Xdebug, Supervisor)
- MySQL 8.0
- Redis
- Mailpit
- MinIO
- phpMyAdmin
- Composer
- Ngrok
- GitLab Runner (local)


##  Access URLs

- **Web:** [http://localhost:8081](http://localhost:8081)
- **Mailpit:** [http://localhost:8025](http://localhost:8025)
- **phpMyAdmin:** [http://localhost:8080](http://localhost:8080)
- **MinIO:** [http://localhost:9000](http://localhost:9000) (default user/pass: `minioadmin`)
- **Ngrok:** [https://dashboard.ngrok.com](https://dashboard.ngrok.com)


## 🔧 Configuration Notes

If you need to increase limits for large uploads (e.g., importing large SQL files in phpMyAdmin), update the following settings:

- `upload_max_filesize=1G`
- `post_max_size=1G`
- `memory_limit=512M`
- `max_execution_time=300`
- `max_input_time=300`

These can be set in:
- `php` container: via `custom.ini`
- `phpMyAdmin` container: via environment variables

## 🔐 Default Login Information

- **MySQL**
  - Host: `mysql`
  - Port: `3306`
  - Database: `app_db`
  - User: `app_user`
  - Password: `secret`

- **phpMyAdmin**
  - URL: http://localhost:8080
  - Login: `app_user`
  - Password: `secret`

- **MinIO**
  - URL: http://localhost:9000
  - Console: http://localhost:9001
  - Access Key: `minioadmin`
  - Secret Key: `minioadmin`


## 🛠️ Quick Start

```bash
docker compose up -d --build
```
