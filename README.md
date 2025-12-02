# Aegis Blocklist

**Content safety where ad blockers don't go.**

Aegis is a comprehensive DNS blocklist covering harmful content categories that major blocklists (Hagezi, OISD, StevenBlack) do NOT cover. Those lists focus on ads and tracking - Aegis focuses on content-based harms critical for parental controls and child safety.

## The Problem

### Kids bypass filters easily

Modern kids are tech-savvy. When they hit a block, they:
1. **Install a VPN app** - Free VPNs are everywhere (App Store, Play Store, browser extensions)
2. **Use web proxies** - Sites like HideMyAss, KProxy work instantly
3. **Change DNS settings** - Switch to 8.8.8.8 or 1.1.1.1 to bypass router-level filtering
4. **Use Tor or I2P** - Anonymous browsing bypasses everything

Most parental control solutions don't block VPN/proxy sites themselves - they only block content *through* the filter. Once bypassed, all protection is gone.

### Major blocklists miss harmful content

We tested Aegis domains against the three largest blocklists combined (522,000+ domains):

| Blocklist | Domains | Focus |
|-----------|---------|-------|
| Hagezi Pro | 332,503 | Ads, tracking, malware |
| OISD Big | 217,129 | Ads, tracking |
| StevenBlack | 84,192 | Ads, malware |

**Result: 98.2% of Aegis domains are NOT in any of these lists.**

These lists are excellent for ads and malware, but they don't cover:
- Self-harm and suicide communities
- Incel/blackpill radicalization forums
- Neo-Nazi and hate sites
- Gore and shock content
- Predator-risk apps (Omegle clones)
- Essay mills and cheating services
- VPN/proxy bypass tools

## The Solution

> **Note:** Aegis is not a replacement for comprehensive parental control solutions like [Qustodio](https://www.qustodio.com/), [Bark](https://www.bark.us/), or [Net Nanny](https://www.netnanny.com/). Those tools provide activity monitoring, screen time management, and alerts that DNS blocking cannot. Aegis enhances these solutions by blocking bypass methods (VPNs, proxies) and harmful content categories they may miss.

### Why per-device, not router-level?

**Router-level blocking is easily bypassed.** Kids can:
- Use a VPN app to tunnel around your router's DNS
- Switch to mobile data
- Use a friend's hotspot
- Change their device's DNS settings to 8.8.8.8

**Per-device installation** ensures filtering works everywhere - at home, school, friends' houses, and on mobile data. It's harder to bypass because the blocking happens on the device itself.

---

### Option A: NextDNS (Recommended)

[NextDNS](https://nextdns.io) is a cloud-based DNS filter with a generous free tier (300k queries/month). The **NextDNS CLI** installs as a system service that requires admin privileges to remove.

**Install NextDNS CLI on each device:**

| Platform | Install Command | Docs |
|----------|-----------------|------|
| **Windows** | `winget install NextDNS.cli` or [download installer](https://github.com/nextdns/nextdns/releases) | [Windows Guide](https://github.com/nextdns/nextdns/wiki/Windows) |
| **macOS** | `brew install nextdns/tap/nextdns` | [macOS Guide](https://github.com/nextdns/nextdns/wiki/macOS) |
| **Linux** | `sh -c 'sh -c "$(curl -sL https://nextdns.io/install)"'` | [Linux Guide](https://github.com/nextdns/nextdns/wiki/Debian-Ubuntu) |
| **iOS** | App Store: "NextDNS" | [iOS Guide](https://apple.co/2nVcfQu) |
| **Android** | Play Store: "NextDNS" | [Android Guide](https://play.google.com/store/apps/details?id=io.nextdns.NextDNS) |

Then add Aegis domains to your NextDNS denylist at [my.nextdns.io](https://my.nextdns.io) → Denylist.

**Also enable in NextDNS:**
- **Security**: Block Newly Registered Domains, Block DNS Rebinding
- **Privacy**: Block Disguised Third-Party Trackers
- **Parental Controls**: Porn, Gambling, Dating, Piracy (as appropriate)

**Enable these blocklists** (Privacy → Blocklists):

| Blocklist | Domains | Why |
|-----------|---------|-----|
| [NextDNS Ads & Trackers](https://github.com/nextdns/metadata) | Built-in | NextDNS's own curated list |
| [OISD](https://oisd.nl/) | 217k | "Set and forget" - balanced, low false positives |
| [Hagezi Pro](https://github.com/hagezi/dns-blocklists) | 332k | Comprehensive ads/tracking/malware |
| [StevenBlack](https://github.com/StevenBlack/hosts) | 84k | Unified hosts with extensions |

These block ads and tracking. **Aegis adds content safety on top.**

---

### Option B: Hosts File (Free, No Account)

For users who don't want a cloud service, edit the system hosts file directly. This is free, works offline, and requires no account - but you must update manually.

**Windows** (run as Administrator):
```powershell
# Download Aegis hosts format
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/0xDarkMatter/aegis/main/formats/hosts.txt" -OutFile "$env:TEMP\aegis-hosts.txt"

# Append to system hosts file
Get-Content "$env:TEMP\aegis-hosts.txt" | Add-Content "C:\Windows\System32\drivers\etc\hosts"
```

**macOS/Linux** (run as root):
```bash
# Download and append to hosts file
curl -s "https://raw.githubusercontent.com/0xDarkMatter/aegis/main/formats/hosts.txt" | sudo tee -a /etc/hosts
```

> **Tip:** Use [HostsMan](https://www.abelhadigital.com/hostsman/) (Windows) or [Gas Mask](https://github.com/2ndalpha/gasmask) (macOS) to manage hosts file updates.

**Hardening the hosts file (CRITICAL):**

The hosts file only works if children cannot edit it. **They must NOT have admin access.**

| Platform | How to Secure |
|----------|---------------|
| **Windows** | Create a Standard User account for your child. Only admins can edit the hosts file. Never give children admin passwords. |
| **macOS** | Use a non-admin account. The hosts file requires `sudo` to edit. Enable Parental Controls. |
| **Linux** | Use a non-root account. Consider making hosts file immutable: `sudo chattr +i /etc/hosts` |

**Windows - verify hosts file is protected:**
```powershell
# Check that hosts file requires admin to edit
icacls "C:\Windows\System32\drivers\etc\hosts"
# Should show BUILTIN\Administrators with full control, not regular users
```

> **Warning:** If your child has admin access, they can simply delete the hosts file entries. Use NextDNS with device policies instead.

---

### Option C: Pi-hole / AdGuard Home (Network-wide)

For technically-inclined users running a home DNS server. Note: this is router-level and can be bypassed with VPNs - combine with per-device solutions.

**Pi-hole:**
```bash
# Add as a blocklist in Pi-hole admin → Adlists
https://raw.githubusercontent.com/0xDarkMatter/aegis/main/formats/hosts.txt
```

**AdGuard Home:**
```bash
# Add as DNS blocklist in Settings → DNS blocklists
https://raw.githubusercontent.com/0xDarkMatter/aegis/main/grades/standard.txt
```

## What Aegis Blocks

**906 unique domains across 21 categories:**

| Category | Domains | Examples |
|----------|---------|----------|
| VPN/Proxy Bypass | 217 | NordVPN, ExpressVPN, TunnelBear, web proxies |
| AI Adult Content | 92 | Nudify sites, AI porn generators, deepfakes |
| Piracy/Torrents | 74 | 1337x, RARBG, torrent sites |
| Stalkerware | 66 | mSpy, FlexiSpy, phone trackers |
| Crypto Scams | 55 | Pump-and-dump schemes, rug pulls |
| Predator-Risk Apps | 47 | Omegle clones, anonymous teen apps |
| Gambling (Intl) | 46 | Bet365, DraftKings, FanDuel |
| Hate/Extremism | 46 | Neo-Nazi forums, alt-right media |
| Cheating/Essay Mills | 36 | EduBirdie, Chegg, AI bypass tools |
| Gambling (AU) | 35 | Sportsbet, TAB, Ladbrokes AU |
| Gambling (Crypto) | 35 | Stake, Roobet, crypto casinos |
| Manosphere | 31 | Red pill, PUA, MGTOW communities |
| Self-Harm | 26 | Pro-ana, thinspo, suicide method sites |
| Gore/Shock | 24 | Shock sites, death videos |
| Incel/Blackpill | 17 | Incels.is, looksmax forums |
| Adult Services | 15 | Escort directories, sugar dating |
| Doxxing/Harassment | 13 | Kiwi Farms, doxbin |
| Age Bypass | 12 | Age verification circumvention |
| Adult Content | 8 | Niche porn sites missed by blocklists |
| Drug Forums | 8 | Harm reduction, RC vendors |

## Grades

| Grade | Domains | Description |
|-------|---------|-------------|
| **Core** | 117 | Highest harm: self-harm/suicide, predator-risk apps, hate/extremism, gore, doxxing |
| **Standard** | 596 | Core + VPNs, gambling, cheating, adult, incel/manosphere - **recommended for most** |
| **Strict** | 611 | Standard + weapons, crypto scams, stalkerware, borderline content |
| **Maximum** | 611 | All categories including optional (dating apps, academic tools) |

## File Structure

```
aegis/
├── grades/                 # Cumulative grade lists
│   ├── core.txt           # Essential only
│   ├── standard.txt       # Core + Standard (recommended)
│   ├── strict.txt         # + Strict
│   └── maximum.txt        # Everything
│
├── categories/             # Individual category lists
│   ├── self-harm.txt
│   ├── incel-blackpill.txt
│   ├── manosphere.txt
│   ├── hate-extremism.txt
│   ├── gore-shock.txt
│   ├── predator-risk.txt
│   ├── gambling-au.txt
│   ├── gambling-intl.txt
│   ├── gambling-crypto.txt
│   ├── cheating-mills.txt
│   ├── vpn-bypass.txt
│   └── ai-adult.txt
│
├── optional/               # Toggleable (not in standard grades)
│   ├── gateway-manosphere.txt  # Andrew Tate, alpha influencers
│   ├── academic-tools.txt      # Chegg, AI writers
│   └── dating-apps.txt         # Tinder, Bumble, etc.
│
└── formats/                # Different format outputs
    ├── hosts.txt          # 0.0.0.0 format
    ├── adblock.txt        # AdBlock format
    └── dnsmasq.txt        # dnsmasq format
```

## Locking It Down (IMPORTANT)

Installing a DNS filter isn't enough. **Kids can uninstall apps, change settings, or find workarounds.**

**The Golden Rule:**
- **YOU (the parent)** = Administrator / knows the passcode
- **YOUR CHILD** = Standard User / no admin access

If your child has admin rights or knows your passwords, they can undo everything.

**[Read the full Device Lockdown Guide →](DEVICE-LOCKDOWN.md)**

Step-by-step instructions for Windows, macOS, iOS, Android, and Chromebook.

## Philosophy

- **Enhance, don't duplicate** - 98.2% of Aegis domains are NOT in Hagezi/OISD/StevenBlack
- **Block the bypass** - VPN/proxy blocking is as important as content blocking
- **Safety first** - When in doubt, block. False positives are preferable to missed threats
- **Regional awareness** - Includes AU-specific content often missed by US-focused lists

## Development

### Data Flow

The SQLite database (`data/aegis.db`) is the **source of truth**. All text files are GENERATED from the database.

```
┌─────────────────────────────────────────────────────────────────────┐
│                         WORKFLOW                                     │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│   1. ADD DOMAIN TO DB                                                │
│      └─> python scripts/add_domain.py <domain> <category>            │
│                                                                      │
│   2. RUN PIPELINE (liveness → content → LLM review)                  │
│      └─> python scripts/run_pipeline.py                              │
│                                                                      │
│   3. EXPORT FILES FROM DB                                            │
│      └─> python scripts/generate_blocklists.py                       │
│                                                                      │
│   Generated files:                                                   │
│   ├── grades/*.txt        (cumulative: core, standard, strict, max)  │
│   ├── categories/*.txt    (one file per category)                    │
│   └── formats/*.txt       (hosts, adblock, dnsmasq)                  │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### Key Scripts

| Script | Purpose |
|--------|---------|
| `scripts/import_all.py` | Initial import from legacy txt files → DB |
| `scripts/run_pipeline.py` | Process domains: liveness → content → LLM review |
| `scripts/generate_blocklists.py` | **Generate txt files FROM database** |
| `scripts/show_reviews.py` | Display sample reviews with reasoning |
| `src/exporter.py` | Exporter class (used by generate_blocklists.py) |
| `src/database.py` | Database schema and operations |
| `src/reviewer.py` | LLM-powered domain assessment |
| `src/content_fetcher.py` | Hybrid fetcher (aiohttp + Firecrawl) |
| `src/liveness.py` | DNS and HTTP liveness checks |

### Database Schema

```sql
domains           -- All domains with category, status, grade
domain_reviews    -- LLM decisions, scores, reasoning
domain_verification -- Liveness check results (DNS, HTTP status)
domain_content    -- Fetched page content (title, headings, body)
categories        -- Category definitions with grades
```

### Adding New Domains

```bash
# Option 1: Direct to DB
sqlite3 data/aegis.db "INSERT INTO domains (domain, category_id, status) VALUES ('example.com', 'vpn-bypass', 'pending')"

# Option 2: Run pipeline on pending domains
python scripts/run_pipeline.py
```

**DO NOT** manually edit `categories/*.txt` files - they are generated output, not input.

## License

CC0 (Public Domain) - Use freely, no attribution required.

## Related Projects

- [Hagezi DNS Blocklists](https://github.com/hagezi/dns-blocklists) - Comprehensive ad/tracking blocking
- [OISD](https://oisd.nl/) - Set-and-forget blocking
- [StevenBlack Hosts](https://github.com/StevenBlack/hosts) - Unified hosts file with ad/malware blocking
- [NextDNS](https://nextdns.io) - Cloud DNS filtering with parental controls

---

*Aegis: The shield of Zeus, protecting from harm.*
