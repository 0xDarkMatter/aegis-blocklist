# Aegis Blocklist

**A child safety DNS blocklist focused on content harms.**

Aegis is a specialized blocklist designed to complement existing solutions like [Hagezi](https://github.com/hagezi/dns-blocklists), [OISD](https://oisd.nl/), and [StevenBlack](https://github.com/StevenBlack/hosts). Those projects are excellent and well-maintained—Aegis doesn't replace them, it fills specific gaps for parents concerned about child safety.

## Why Aegis?

Major blocklists cover a lot of ground including ads, tracking, malware, adult content, gambling, and more. Aegis focuses on **niche categories often missed** and **bypass prevention**:

| Aegis Focus | Why It Matters |
|-------------|----------------|
| **Bypass tools** | VPNs, proxies, and DNS changers that let kids circumvent *any* filter |
| **Self-harm communities** | Pro-ana, thinspo, suicide method sites |
| **Radicalization content** | Incel/blackpill forums, manosphere, hate communities |
| **Predator-risk apps** | Omegle clones, anonymous chat apps popular with minors |
| **Gore/shock content** | Death videos, shock sites |
| **Regional coverage** | Australian gambling and escort sites often missed by US-focused lists |
| **AI adult content** | Nudify sites, deepfakes, AI porn generators—a rapidly growing category |
| **Essay mills** | Cheating services, AI bypass tools |

### The Bypass Problem

Most parental controls only work if kids can't circumvent them. When a child installs a VPN app or uses a web proxy, **all protection is gone**. Aegis blocks 300+ VPN services, proxy sites, and DNS-over-HTTPS endpoints at the DNS level—before they can be used to bypass other filters.

### Why We Block Developer Platforms (GitHub, Vercel, etc.)

**This may surprise you**: Aegis blocks GitHub, Vercel, Netlify, Replit, and similar developer platforms. Here's why.

#### The 2025 Bypass Landscape

Traditional VPN blocking is no longer enough. Modern bypass tools like **Interstellar**, **Doge Unblocker**, **Rammerhead**, and **Ultraviolet** are browser-in-browser proxy networks that:

| Capability | What It Means |
|------------|---------------|
| **Run entirely in browser** | No app to install, no admin rights needed |
| **Use Service Workers** | Intercept all web requests invisibly |
| **Tab cloaking** | Browser tab shows "Google Docs" while browsing anything |
| **about:blank hiding** | Content hidden in blank tabs, evades monitoring |
| **One-click access** | Visit one URL → full unrestricted internet |

A child visits a single URL and immediately bypasses ALL DNS filtering to access predator chats, gore, self-harm content—everything.

#### How Developer Platforms Enable This

| Platform | Abuse Pattern |
|----------|---------------|
| **GitHub** | Hosts Ultraviolet, Interstellar, Rammerhead source code. "Deploy to Vercel" button = 60-second proxy. |
| **Vercel/Netlify** | Free subdomains = infinite proxy mirrors. Primary host for Doge Unblocker. |
| **Replit** | Students deploy proxies during class. Live coding = live bypass. |
| **Glitch** | Ephemeral instances make blocking impossible. |

These platforms provide **near-zero legitimate utility for children** but **one-click access to the worst content on the internet**. Blocking the gateway blocks ALL downstream harm.

> **Philosophy**: If a platform provides more bypass capability than legitimate utility for children, block the entire platform. Individual sites can be whitelisted if legitimately needed.

#### The .buzz TLD

We block the entire `.buzz` TLD. It's heavily abused for ephemeral proxy mirrors (e.g., `mathprofession.buzz`, `zearn.buzz`) traded on Discord. Legitimate `.buzz` sites are rare.

#### Parents: Don't Block Yourself!

**Create TWO NextDNS profiles:**
- **"Kids"** – Apply Aegis blocklist (restrictive)
- **"Parents"** – Unfiltered or minimal filtering

If you apply Aegis to your own devices, you'll block yourself from this GitHub repository, developer documentation, and legitimate tools. Keep at least one device or profile unfiltered for administration.

## Quick Start

### Pi-hole or AdGuard Home (Easiest)

These self-hosted solutions support blocklist URLs natively—just paste and go:

**Pi-hole**: Group Management → Adlists → Add new:
```
https://raw.githubusercontent.com/0xDarkMatter/aegis-blocklist/master/grades/standard.txt
```

**AdGuard Home**: Filters → DNS Blocklists → Add blocklist → Add a custom list:
```
https://raw.githubusercontent.com/0xDarkMatter/aegis-blocklist/master/grades/standard.txt
```

### NextDNS (Cloud - No Self-Hosting)

NextDNS is excellent but doesn't support custom blocklist URLs. Use our interactive import scripts:

**Windows (PowerShell):**
```powershell
iwr https://raw.githubusercontent.com/0xDarkMatter/aegis-blocklist/master/tools/nextdns-import.ps1 -OutFile aegis.ps1
.\aegis.ps1
```

**macOS/Linux:**
```bash
curl -sLO https://raw.githubusercontent.com/0xDarkMatter/aegis-blocklist/master/tools/nextdns-import.sh
bash nextdns-import.sh
```

The script will prompt you for:
- **Config ID**: NextDNS → Select your Kids profile → Setup tab → ID field
- **API Key**: [my.nextdns.io/account](https://my.nextdns.io/account) → API section
- **Blocking level**: Choose from core, standard, strict, or maximum

**Also enable built-in controls** at [my.nextdns.io](https://my.nextdns.io):
- Security → Threat Intelligence Feeds
- Parental Control → Porn, Gambling, Piracy, Dating

### ControlD (Cloud Alternative)

Similar to NextDNS but with more [3rd party filter options](https://docs.controld.com/docs/filters). We're requesting Aegis be added to their filter library.

### Hosts File (Any Device)

```bash
# Linux/macOS
curl -sL "https://raw.githubusercontent.com/0xDarkMatter/aegis-blocklist/master/formats/hosts.txt" | sudo tee -a /etc/hosts
```

```powershell
# Windows (as Administrator)
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/0xDarkMatter/aegis-blocklist/master/formats/hosts.txt" -OutFile "$env:TEMP\aegis.txt"
Get-Content "$env:TEMP\aegis.txt" | Add-Content "C:\Windows\System32\drivers\etc\hosts"
```

## Categories

**900+ domains across 21 categories:**

### Core (Always Blocked)
| Category | Count | Description |
|----------|-------|-------------|
| Self-Harm | 26 | Pro-ana, thinspo, suicide method sites |
| Gore/Shock | 24 | Death videos, shock content |
| Predator-Risk | 47 | Omegle clones, anonymous chat apps |
| Hate/Extremism | 46 | Neo-Nazi forums, alt-right media |
| Incel/Blackpill | 17 | Incels.is, looksmax, blackpill forums |
| Doxxing | 13 | Kiwi Farms, doxbin |

### Standard (Recommended)
| Category | Count | Description |
|----------|-------|-------------|
| VPN/Proxy Bypass | 315 | VPN services, web proxies, gateway platforms, browser-based proxies |
| Gambling (AU) | 35 | Australian betting sites |
| Gambling (Intl) | 46 | International gambling |
| Gambling (Crypto) | 35 | Crypto casinos |
| AI Adult | 92 | Nudify, deepfakes, AI porn |
| Cheating/Mills | 36 | Essay mills, AI bypass tools |
| Manosphere | 31 | Red pill, MGTOW, PUA |
| Piracy | 74 | Torrent sites, streaming |
| Stalkerware | 66 | mSpy, FlexiSpy, trackers |
| Adult Services | 15 | Escort directories |

### Strict (Opt-in)
| Category | Count | Description |
|----------|-------|-------------|
| Weapons | - | Weapons info, 3D print files |
| Crypto Scams | 55 | Rug pulls, pump schemes |
| Cult Recruitment | - | Cult sites, high-control groups |

## Grades

| Grade | Domains | Use Case |
|-------|---------|----------|
| `core.txt` | 117 | Minimum for all minors |
| `standard.txt` | 596 | **Recommended for most families** |
| `strict.txt` | 611 | Enhanced protection |
| `maximum.txt` | 611 | Everything including optional |

## File Structure

```
aegis-blocklist/
├── grades/           # Cumulative lists
│   ├── core.txt
│   ├── standard.txt  # ← Start here
│   ├── strict.txt
│   └── maximum.txt
├── categories/       # Individual categories (mix and match)
├── optional/         # Dating apps, academic tools
└── formats/
    ├── hosts.txt     # 0.0.0.0 format
    ├── adblock.txt   # ||domain^
    └── dnsmasq.txt   # address=/domain/
```

## Important: Lock Down Devices

DNS blocking only works if kids can't bypass it. **[Read the Device Lockdown Guide →](DEVICE-LOCKDOWN.md)**

The key principle:
- **Parent** = Administrator / knows passcodes
- **Child** = Standard user / no admin access

If your child has admin rights, they can undo everything.

## Philosophy

- **Complement, don't duplicate** - Works alongside major blocklists, not instead of them
- **Block the bypass** - VPN/proxy blocking is critical for any filtering to work
- **Child safety first** - Categories chosen specifically for protecting minors
- **Regional awareness** - Includes AU-specific content often missed by US-focused lists

## Related Projects

These are excellent blocklists—use them alongside Aegis:

- **[Hagezi](https://github.com/hagezi/dns-blocklists)** - Comprehensive blocking with NSFW, gambling, piracy options
- **[OISD](https://oisd.nl/)** - "Set and forget" with low false positives, includes NSFW lists
- **[StevenBlack](https://github.com/StevenBlack/hosts)** - Unified hosts with porn, gambling, social extensions
- **[NextDNS](https://nextdns.io)** - Cloud DNS with built-in parental controls

## License

CC0 (Public Domain) - Use freely, no attribution required.

---

*Aegis (αἰγίς): The shield of Zeus, protecting from harm.*
