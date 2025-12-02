# Device Lockdown Guide

**How to prevent your child from bypassing DNS filtering**

Installing a DNS filter isn't enough. Kids can uninstall apps, change settings, or find workarounds. These guides show you how to lock down each device so they can't undo your work.

---

## The Golden Rule

| Account Type | Who Uses It | Can Change Settings? |
|--------------|-------------|---------------------|
| **Administrator / Parent** | YOU | Yes - full control |
| **Standard / Child** | YOUR CHILD | No - cannot install or remove apps |

**If your child knows the admin password or has admin rights, none of this works. They can undo everything.**

---

## Choose Your Platform

| Platform | Guide | Best For |
|----------|-------|----------|
| [**Windows**](DEVICE-LOCKDOWN-WINDOWS.md) | Desktop/laptop lockdown | Family PC, gaming PC |
| [**macOS**](DEVICE-LOCKDOWN-MACOS.md) | Mac lockdown | MacBooks, iMacs |
| [**iOS / iPadOS**](DEVICE-LOCKDOWN-IOS.md) | iPhone & iPad | Kids' mobile devices |
| [**Android**](DEVICE-LOCKDOWN-ANDROID.md) | Android phones & tablets | Samsung, Pixel, etc. |
| [**Chromebook**](DEVICE-LOCKDOWN-CHROMEBOOK.md) | Chrome OS devices | School/home Chromebooks |
| [**Router**](DEVICE-LOCKDOWN-ROUTER.md) | Network-wide filtering | Smart TVs, consoles, IoT |

---

## Quick Comparison

| Platform | Control Method | Difficulty | Bypass Risk |
|----------|---------------|------------|-------------|
| Windows | Standard User account + CLI service | Medium | Low |
| macOS | Standard User account + daemon | Medium | Low |
| iOS | Screen Time passcode | Easy | Low |
| Android | Google Family Link | Easy | Low |
| Chromebook | Supervised Google account | Easy | Low |
| Router | Router DNS settings | Medium | Medium* |

*Router filtering can be bypassed by VPN apps on phones/computers. Use in addition to per-device protection.

---

## Troubleshooting

### "NextDNS isn't working"

1. Visit [test.nextdns.io](https://test.nextdns.io) - does it show your config ID?
2. If not, check the NextDNS app is enabled/running
3. On desktop: run `nslookup google.com` - server should show `127.0.0.1`

### "My child removed NextDNS"

They had admin access or knew your passcode. You need to:
1. Change your admin/Screen Time password
2. Reinstall NextDNS
3. Review the guide for your platform to ensure proper lockdown

### "Blocked sites are still loading"

1. Clear browser cache and cookies
2. Try a different browser
3. Check NextDNS logs at [my.nextdns.io](https://my.nextdns.io) → Logs
4. Make sure the domain is in your denylist

---

## Remember

The best technical controls can be defeated if your child has admin access or knows your passwords.

- **Keep credentials secret** - never share admin passwords or Screen Time passcodes
- **Audit regularly** - check that settings haven't been changed
- **Talk to your kids** - technical controls are part of a broader conversation about online safety
