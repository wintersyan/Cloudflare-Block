# Description

This script automatically enables Cloudflare **I'm Under Attack Mode** when the server load average becomes too high, and disables it once the load returns to normal.

It is designed to help mitigate traffic spikes, abusive requests, or potential DDoS situations by temporarily increasing Cloudflare protection automatically.

*I think this scenario is completely useless in 2026, but I find it funny to give it a second life.*

# Configuration

## Download the Repository

Clone the repository:

```bash
git clone https://github.com/your-repository/cloudflare-under-attack.git
```

Enter the project directory:

```bash
cd cloudflare-under-attack
```

Make the script executable:

```bash
chmod +x cloudflare-under-attack.sh
```

---

## Configure Your API

Create a Cloudflare API Token from your Cloudflare dashboard:

1. [My Profile](https://dash.cloudflare.com/profile/settings)
2. [API Tokens](https://dash.cloudflare.com/profile/api-tokens)
3. Create Token

Recommended permissions:

```text
Zone.Zone:Read
Zone.Settings:Edit
```

You will also need your:

* Zone ID
* API Token

---

## Create / Edit `.env`

Create the environment file:

```bash
sudo nano /etc/cloudflare-under-attack.env
```

Example configuration:

```bash
API_TOKEN="your_cloudflare_api_token"
ZONE_ID="your_zone_id"
```

Secure the file:

```bash
sudo chmod 600 /etc/cloudflare-under-attack.env
sudo chown root:root /etc/cloudflare-under-attack.env
```

---

## Cron

Edit the crontab:

```bash
sudo crontab -e
```

Run the script every minute:

```cron
* * * * * /opt/scripts/cloudflare-under-attack.sh >/dev/null 2>&1
```

---

# Logs

View logs with:

```bash
journalctl -t cloudflare-under-attack
```

---

# License

**Cloudflare-Block** are distributed under the [The MIT License](https://opensource.org/licenses/MIT).
