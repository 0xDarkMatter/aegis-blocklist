# Chromebook Lockdown Guide

[← Back to Device Lockdown Overview](DEVICE-LOCKDOWN.md)

---

## Step 1: Set Up a Supervised Google Account

1. On your computer, go to [families.google.com](https://families.google.com)
2. Click **Create a family** (if you haven't already)
3. Add your child's Google account to your family
4. Turn on supervision for their account

---

## Step 2: Sign Your Child Into the Chromebook

1. On the Chromebook, sign OUT of any existing account
2. Click **Add person** or **Sign in**
3. Sign in with your CHILD'S supervised Google account (not yours)

---

## Step 3: Configure via Family Link

On YOUR phone:

1. Open **Family Link**
2. Select your child → **Controls**
3. Under **Chrome settings**, restrict sites as needed
4. Under **Apps**, require approval for extensions

---

## Step 4: Set Up DNS Filtering

Chromebooks don't support the NextDNS app directly. Choose one of these options:

### Option A: DNS-over-HTTPS in Chrome (Recommended)

1. On the Chromebook, open Chrome
2. Go to **Settings** → **Privacy and security** → **Security**
3. Enable **Use secure DNS**
4. Select **Custom** and enter:
   ```
   https://dns.nextdns.io/abc123
   ```
   (Replace `abc123` with your config ID from [my.nextdns.io](https://my.nextdns.io))

### Option B: Configure at Router Level

See the [Router Lockdown Guide](DEVICE-LOCKDOWN-ROUTER.md) to set NextDNS on your home router. This filters all devices on your network including the Chromebook.

---

## Optional: Additional Settings

### Restrict Chrome Extensions

In Family Link:
1. Select your child → **Controls** → **Google Chrome**
2. Under "Extensions," require approval for all extensions
3. Block VPN and proxy extensions

### Block Incognito Mode

Family Link automatically disables Incognito mode for supervised accounts.

### Manage Screen Time

1. Family Link → your child → **Controls** → **Daily limit**
2. Set Chromebook usage limits

### Block Specific Sites

1. Family Link → your child → **Controls** → **Google Chrome**
2. Manage sites → Add sites to block

---

## School Chromebooks

**Note:** School-issued Chromebooks are typically managed by the school district.

- The school controls what's installed and accessible
- You usually cannot add your own DNS filtering
- Contact the school's IT department about home filtering options
- Some schools allow parents to request additional restrictions

---

## Troubleshooting

### DoH not working

1. Make sure you entered the URL correctly: `https://dns.nextdns.io/YOUR_CONFIG_ID`
2. Visit [test.nextdns.io](https://test.nextdns.io) to verify
3. Try restarting Chrome

### Child disabled DoH

1. Check Chrome settings on the Chromebook
2. Consider using router-level filtering instead (harder to bypass)
3. In Family Link, you may be able to enforce Chrome policies

### Can't sign into supervised account

- Make sure the account is properly supervised at [families.google.com](https://families.google.com)
- The child account needs to be part of your family group
- Try signing out and back in

---

[← Back to Device Lockdown Overview](DEVICE-LOCKDOWN.md)
