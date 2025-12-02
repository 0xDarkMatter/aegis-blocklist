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

Most parental controls only work if kids can't circumvent them. When a child installs a VPN app or uses a web proxy, **all protection is gone**. Aegis blocks 200+ VPN services, proxy sites, and DNS-over-HTTPS endpoints at the DNS level—before they can be used to bypass other filters.

## Quick Start

### NextDNS (Recommended)

1. Sign up at [nextdns.io](https://nextdns.io)
2. Enable parental controls (Porn, Gambling, etc.)
3. Add Aegis to your denylist: [my.nextdns.io](https://my.nextdns.io) → Denylist → Import

**Also enable these blocklists** (they handle ads/tracking/malware):
- [OISD](https://oisd.nl/) - Balanced, low false positives
- [Hagezi](https://github.com/hagezi/dns-blocklists) - Comprehensive protection

### Pi-hole / AdGuard Home

```
https://raw.githubusercontent.com/0xDarkMatter/aegis-blocklist/master/grades/standard.txt
```

### Hosts File

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
| VPN/Proxy Bypass | 217 | VPN services, web proxies, DNS changers |
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
