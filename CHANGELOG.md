# Changelog

All notable changes to Aegis Blocklist are documented in this file.

Format loosely follows [Keep a Changelog](https://keepachangelog.com/).
Versions are date-anchored, not semver — this is a curated blocklist, not a
library. Minor bumps reflect substantive content additions or structural
changes; patch bumps reflect data fixes.

## [v0.3.0] — 2026-05-14

The 2026 bypass refresh: catches up on five months of new VPN extensions,
browser-in-browser proxies, and crypto wallets gaining traction since v0.2.0.

### Added

**vpn-bypass (+21)**
- 2026 browser-in-browser proxies & web proxies:
  `classroom6x.us.com`, `croxyproxy.com`, `blockaway.com`, `blockaway.net`,
  `bingle.pw`, `yuyuproxy.com`, `proxycroxy.io`, `youtubeunblocked.live`,
  `freeproxy.io`
- Modern proxy client GUIs: `clash-verge.org` (Mihomo / Clash Meta)
- Chrome / Edge VPN extension vendors detected in the wild:
  `ai-vpn.com`, `colovpn.app`, `goodervpn.com`, `homixvpn.homix-technologies.com`,
  `homix-technologies.com`, `horizonvpn.org`, `horizonsecurity.app`,
  `ltvpn.org`, `uku.im`, `unblock.im`, `vuzevpn.com`

**crypto-scams (+9)**
- Major crypto wallets (same child-onramp threat as MetaMask):
  `metamask.io`, `phantom.app`, `trustwallet.com`, `rabby.io`,
  `backpack.app`, `backpack.exchange`, `solflare.com`
- Major exchanges acting as wallet front-doors:
  `coinbase.com`, `okx.com`

### Fixed

- Domains added via direct DB insert defaulted to `status='pending'`, so
  they shipped in `categories/*.txt` but were **missing from the
  publishable `grades/*.txt` and `formats/*.txt` bundles**. Promoted all
  recent additions to `status='blocked'` and republished.

### Counts

| Grade    | v0.2.0 | v0.3.0 | Δ    |
|----------|--------|--------|------|
| core     | 117    | 130    | +13  |
| standard | 596    | 702    | +106 |
| strict   | 611    | 727    | +116 |
| maximum  | 611    | 727    | +116 |

## [v0.2.0] — 2025-12-04

First post-launch content refresh: discovery pipeline + watchlist review.

### Added

- 17 domains via automated discovery pipeline (`79e2193`).
- 16 domains via watchlist review covering vpn-bypass, crypto-scams,
  cheating-mills, ai-adult, gambling-intl, stalkerware, self-harm,
  piracy-torrents, adult-services, doxxing-harassment, predator-risk
  (`4dc72e1`).

### Changed

- `nextdns-import.sh` / `aegis-import.bat`: interactive mode, real progress
  bar, clearer input prompts, double-click `.bat` installer for Windows
  users.

## [v0.1.0] — 2025-12-03

Initial public release.

### Added

- Curated child-safety DNS blocklist (~620 domains across 21 categories).
- Four grade tiers: `core` / `standard` / `strict` / `maximum`.
- Three publish formats: `hosts.txt`, `adblock.txt`, `dnsmasq.txt`.
- 21 category files in `categories/` for mix-and-match use.
- Import tooling for NextDNS (`nextdns-import.sh`, `aegis-import.bat`).
- Device-lockdown guides for Windows / macOS / iOS / Android / Chromebook /
  Router (see `DEVICE-LOCKDOWN-*.md`).
- README framing as a *complement* to Hagezi / OISD / StevenBlack, not a
  replacement.

[v0.3.0]: https://github.com/0xDarkMatter/aegis-blocklist/releases/tag/v0.3.0
[v0.2.0]: https://github.com/0xDarkMatter/aegis-blocklist/commits/4dc72e1
[v0.1.0]: https://github.com/0xDarkMatter/aegis-blocklist/commits/initial
