# Router Lockdown Guide

[← Back to Device Lockdown Overview](DEVICE-LOCKDOWN.md)

---

## When to Use Router Filtering

Some devices can't run the NextDNS app:
- Smart TVs (Samsung, LG, etc.)
- Apple TV, Roku, Fire TV
- PlayStation, Xbox, Nintendo Switch
- Smart home devices, IoT

For these, configure NextDNS on your **router** so all devices on your network are filtered.

> **⚠️ Warning:** Router-level filtering can be bypassed if a device uses its own DNS (like a VPN app on a phone). Use router filtering **in addition to** per-device protection, not instead of it.

---

## Step 1: Link Your IP Address to NextDNS

Since routers can't log in, NextDNS identifies your network by IP address.

1. Go to [my.nextdns.io](https://my.nextdns.io) → **Setup**
2. Scroll to **Linked IP**
3. Click **Link IP** - this registers your current home IP address
4. If your IP changes (common with home internet), enable **Dynamic DNS** or re-link periodically

---

## Step 2: Find Your Router's Admin Page

Open a browser and try these addresses:
- `192.168.1.1` (most common)
- `192.168.0.1` (Netgear, D-Link)
- `10.0.0.1` (some ISPs)
- `192.168.2.1` (Belkin)

**Or find your gateway:**
- **Windows:** Open Command Prompt → `ipconfig` → look for "Default Gateway"
- **Mac:** System Settings → Network → Wi-Fi → Details → Router

---

## Step 3: Log Into Your Router

Default credentials (check your router's sticker if these don't work):

| Brand | Default Username | Default Password |
|-------|------------------|------------------|
| Most routers | admin | admin |
| Netgear | admin | password |
| Linksys | admin | admin |
| ASUS | admin | admin |
| TP-Link | admin | admin |
| ISP-provided | (on the router sticker) | (on the router sticker) |

> **🚨 CRITICAL: Change the default password now!**
>
> If you haven't changed your router password from the default, **do it immediately.** Anyone (including your child) can look up the default password online and change your DNS settings back.

---

## Step 4: Configure DNS Settings

Find the DNS settings (location varies by router):
- **ASUS:** WAN → Internet Connection → DNS
- **Netgear:** Internet → DNS Addresses
- **TP-Link:** DHCP → DHCP Settings → Primary/Secondary DNS
- **Linksys:** Connectivity → Internet Settings → DNS
- **Generic:** Look for WAN, Internet, DHCP, or Network settings

Enter these NextDNS servers:

| Setting | Value |
|---------|-------|
| Primary DNS | `45.90.28.0` |
| Secondary DNS | `45.90.30.0` |

**Or use servers with your config ID embedded (more reliable):**

Find your personalized IPs at: [my.nextdns.io](https://my.nextdns.io) → **Setup** → scroll to **Routers** section

---

## Step 5: (Optional) Use DNS-over-HTTPS

Some modern routers support encrypted DNS:

### ASUS (Merlin firmware):
1. Go to **WAN** → **Internet Connection**
2. Scroll to **WAN DNS Setting**
3. Click **Assign** next to DNS Server
4. Enter your NextDNS IPs (find them at [my.nextdns.io](https://my.nextdns.io) → Setup → Routers)
5. Set **Prevent client auto DoH** → **Yes** (blocks devices bypassing your DNS)
6. Optional: Set **DNS Privacy Protocol** → **DNS-over-TLS (DoT)** and add server: `dns.nextdns.io`

### pfSense / OPNsense:
1. Services → DNS Resolver → Custom Options
2. Add DoH upstream to NextDNS

### Other routers:
Check if your router supports DoH/DoT. If not, standard DNS still works.

---

## Step 6: Verify It's Working

1. Reboot your router (or wait a few minutes for DNS cache to clear)
2. On any device connected to your network, visit [test.nextdns.io](https://test.nextdns.io)
3. It should show your NextDNS configuration ID and "You're using NextDNS"

---

## Step 7: Lock Down Your Router

**Prevent your child from changing router settings:**

1. **Change the admin password** to something strong that only you know
2. **Disable remote management** (if you don't need it)
3. **Hide the router physically** if possible (or lock the room/closet it's in)
4. Some routers let you disable the login page on Wi-Fi (admin only via ethernet)

---

## Common Router Brands - Quick Setup Links

| Brand | Setup Guide |
|-------|-------------|
| ASUS | [asus.com/support](https://www.asus.com/support/) → search "DNS" |
| Netgear | [kb.netgear.com](https://kb.netgear.com) → search "change DNS" |
| TP-Link | [tp-link.com/support](https://www.tp-link.com/support/) |
| Linksys | [linksys.com/support](https://www.linksys.com/support/) |
| Ubiquiti/UniFi | Settings → Networks → (network) → DHCP → DNS Server |
| eero | eero app → Settings → Network Settings → DNS → Custom |
| Google Wifi/Nest | Google Home app → Wifi → Settings → Networking → DNS |

---

## Devices That Ignore Router DNS

Some devices have hardcoded DNS that ignores your router:
- **Google devices** (Chromecast, Nest) → use Google's DNS `8.8.8.8`
- **Roku** → uses its own DNS
- **Some smart TVs** → hardcoded DNS

**Solution: Block external DNS at the firewall level:**

If your router supports firewall rules, block outbound DNS:
- Block outbound traffic to `8.8.8.8`, `8.8.4.4` (Google DNS)
- Block outbound traffic to `1.1.1.1`, `1.0.0.1` (Cloudflare DNS)
- Block outbound UDP/TCP port 53 to anything except your router's IP

This forces devices to use your router's DNS or fail completely.

### Example for ASUS routers:
1. Firewall → Network Services Filter
2. Enable filter
3. Add rules to block port 53 to external IPs

### Example for pfSense:
1. Firewall → Rules → LAN
2. Add rule: Block UDP/TCP 53 to any (except router)
3. Add rule: Allow UDP/TCP 53 to router IP only

---

## Troubleshooting

### DNS changes not taking effect

1. Reboot your router
2. On each device, forget and reconnect to Wi-Fi
3. Or flush DNS cache:
   - Windows: `ipconfig /flushdns`
   - Mac: `sudo dscacheutil -flushcache`

### IP address keeps changing

1. Contact your ISP about a static IP (may cost extra)
2. Use NextDNS Dynamic DNS: install their updater on a always-on computer
3. Use a DDNS service and update your linked IP automatically

### Router doesn't have DNS settings

- Some ISP-provided routers lock DNS settings
- Options: Buy your own router, or use per-device NextDNS apps instead

---

[← Back to Device Lockdown Overview](DEVICE-LOCKDOWN.md)
