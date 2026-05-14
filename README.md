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

Most parental controls only work if kids can't circumvent them. When a child installs a VPN app or uses a web proxy, **all protection is gone**. Aegis blocks 235+ VPN services, proxy sites, browser-extension VPNs, and DNS-over-HTTPS endpoints at the DNS level — before they can be used to bypass other filters.

### Why We Block Developer Platforms (GitHub, Vercel, etc.)

**This may surprise you**: Aegis blocks GitHub, Vercel, Netlify, Replit, and similar developer platforms. Here's why.

#### The 2025–2026 Bypass Landscape

Traditional VPN blocking is no longer enough. The current generation of bypass tools — **Interstellar**, **Classroom 6x**, **Doge Unblocker v5**, **Rammerhead**, **Ultraviolet**, and the **Scramjet / Wisp / Epoxy** stack from Mercury Workshop — are browser-in-browser proxy networks that:

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

NextDNS is excellent but doesn't support custom blocklist URLs. Use our import tool:

**Windows:** [Download aegis-import.bat](https://raw.githubusercontent.com/0xDarkMatter/aegis-blocklist/master/tools/aegis-import.bat) → Right-click, "Save link as", save as `aegis-import.bat` (not .txt) → Double-click to run

**macOS/Linux:** Download and run in Terminal:
```bash
curl -sLO https://raw.githubusercontent.com/0xDarkMatter/aegis-blocklist/master/tools/nextdns-import.sh && bash nextdns-import.sh
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

## Recent Updates

**v0.3.0** (May 2026)

*   🛡️ **2026 bypass-tool refresh** - Added the current crop of browser-in-browser proxies: Classroom 6x (`classroom6x.us.com`), CroxyProxy family (`croxyproxy.com`, `proxycroxy.io`, `youtubeunblocked.live`), Blockaway, Bingle Proxy, YuYuProxy, FreeProxy. These run entirely inside the browser via Service Workers — one URL bypasses every DNS filter.
*   🔌 **VPN extension vendor sweep** - 11 new vendor domains backing in-the-wild Chrome / Edge VPN extensions: AI VPN, Colo, Gooder VPN, HomixVPN, Horizon, KIZ-related, LTVPN, Unblock-Youku (`uku.im`, `unblock.im`), VuzeVPN. Pairs with registry-policy uninstall on managed devices.
*   🪙 **Crypto wallets are now a first-class category** - Added MetaMask, Phantom, Trust Wallet, Rabby, Backpack, Solflare, plus exchange front-doors Coinbase and OKX. Wallets aren't scams *themselves*, but they're the same child-onramp threat: one social-engineering message away from losing real money.
*   🛠️ **Modern proxy clients** - `clash-verge.org` (GUI for the Mihomo / Clash Meta core) — multi-protocol bypass that traditional VPN keyword scanning misses.
*   🐛 **Publishing fix** - Direct-DB additions were defaulting to `status='pending'`, shipping in `categories/` but missing from `grades/*.txt` and `formats/*.txt`. Promoted to `status='blocked'` and republished.

**v0.2.0** (December 2025)

*   🔁 **Discovery + watchlist sweep** - 33 new domains via automated discovery pipeline and watchlist review across vpn-bypass, crypto-scams, cheating-mills, ai-adult, gambling-intl, stalkerware, self-harm, piracy, adult-services, doxxing-harassment, and predator-risk.
*   🛠️ **Import tooling polish** - Real progress bar in `nextdns-import.sh`, clearer prompts, double-click `.bat` installer for Windows.

**v0.1.0** (December 2025)

*   🚀 **Initial release** - Curated child-safety DNS blocklist (~620 domains across 21 categories) focused on bypass prevention, self-harm communities, predator-risk apps, gore/shock content, AI adult content, and AU-regional coverage. Designed to *complement* Hagezi / OISD / StevenBlack rather than replace them. Four grade tiers (core / standard / strict / maximum), three formats (hosts / adblock / dnsmasq), device-lockdown guides for all major platforms.

[View full changelog →](CHANGELOG.md) · [Commits →](https://github.com/0xDarkMatter/aegis-blocklist/commits/master)

## Categories

**727 domains across 21 categories** (as of v0.3.0):

### Core (Always Blocked)
| Category | Count | Description |
|----------|-------|-------------|
| Predator-Risk | 44 | Omegle clones, anonymous chat apps |
| Hate/Extremism | 40 | Neo-Nazi forums, alt-right media |
| Self-Harm | 20 | Pro-ana, thinspo, suicide method sites |
| Gore/Shock | 15 | Death videos, shock content |
| Doxxing | 11 | Kiwi Farms, doxbin |

### Standard (Recommended)
| Category | Count | Description |
|----------|-------|-------------|
| VPN/Proxy Bypass | 235 | VPN services, web proxies, browser-in-browser proxies, VPN browser extensions |
| AI Adult | 69 | Nudify sites, deepfakes, AI porn generators |
| Piracy | 51 | Torrent sites, pirate streaming |
| Stalkerware | 41 | mSpy, FlexiSpy, hidden trackers |
| Gambling (Crypto) | 33 | Crypto casinos, on-chain betting |
| Gambling (Intl) | 33 | International gambling sites |
| Gambling (AU) | 31 | Australian betting sites |
| Cheating/Mills | 20 | Essay mills, AI-bypass cheating tools |
| Manosphere | 19 | Red pill, MGTOW, PUA |
| Adult Services | 13 | Escort directories |
| Incel/Blackpill | 12 | Incels.is, looksmax, blackpill forums |
| Drug Forums | 8 | Drug-discussion forums |
| Adult Content | 7 | Adult sites not covered by Hagezi/OISD |

### Strict (Opt-in)
| Category | Count | Description |
|----------|-------|-------------|
| Crypto Scams + Wallets | 13 | Binary-options scams + child-onramp wallets (MetaMask, Phantom, etc.) |
| Age Verification Bypass | 10 | Sites helping minors fake age checks |
| Weapons / Explosives | 2 | Weapons info, 3D-print files |
| Cult Recruitment | — | Reserved |
| Dangerous Challenges | — | Reserved |

## Grades

| Grade | Domains | Use Case |
|-------|---------|----------|
| `core.txt` | 130 | Minimum for all minors |
| `standard.txt` | 702 | **Recommended for most families** |
| `strict.txt` | 727 | Enhanced protection |
| `maximum.txt` | 727 | Everything including optional |

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
