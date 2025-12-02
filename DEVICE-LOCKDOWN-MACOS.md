# macOS Lockdown Guide

[← Back to Device Lockdown Overview](DEVICE-LOCKDOWN.md)

---

## Step 1: Create Separate Accounts

| Account | Who uses it | Account type |
|---------|-------------|--------------|
| Your account | YOU (the parent) | **Administrator** |
| Child's account | YOUR CHILD | **Standard** |

**How to set this up:**

1. Apple menu → **System Settings** (or System Preferences on older macOS)
2. Click **Users & Groups**
3. Click the lock icon and enter your password
4. Click **+** to add a new user
5. Set account type to **Standard** (NOT Administrator)
6. Enter your child's name and create a password for them
7. **NEVER tell your child your admin password**

---

## Step 2: Get Your NextDNS Configuration ID

1. Go to [my.nextdns.io](https://my.nextdns.io) and sign up (free)
2. Your **Configuration ID** is at the top - looks like `abc123`
3. Write this down

---

## Step 3: Install NextDNS CLI

### Option A: Using Homebrew (if you have it)

1. Log into YOUR admin account
2. Open **Terminal** (Applications → Utilities → Terminal)
3. Run these commands (replace `abc123` with YOUR config ID):

```bash
brew install nextdns/tap/nextdns
sudo nextdns install -config abc123 -report-client-info
sudo nextdns activate
```

4. Enter your password when prompted

### Option B: Direct Install (no Homebrew)

1. Log into YOUR admin account
2. Open **Terminal**
3. Run this one-liner:

```bash
sh -c 'sh -c "$(curl -sL https://nextdns.io/install)"'
```

4. Follow the prompts - enter your Configuration ID when asked
5. Enter your password when prompted

---

## Step 4: Verify It's Working

In Terminal, run:

```bash
sudo nextdns status
```

It should show "running".

Also visit [test.nextdns.io](https://test.nextdns.io) in a browser - it should show your config ID.

---

## Step 5: Enable Screen Time (Extra Protection)

1. System Settings → **Screen Time**
2. Select your child's account
3. Turn on **Content & Privacy Restrictions**
4. Set a Screen Time passcode (different from your login password)
5. Under "Content & Privacy" → restrict app installations

---

## Optional: Additional Hardening

### Make NextDNS config immutable

```bash
# Prevent changes to NextDNS config
sudo chflags schg /etc/nextdns.conf
```

### Disable Terminal for child account

1. System Settings → Screen Time → (child's account)
2. App Limits → add Terminal to blocked apps

### Use MDM Profile (Advanced)

For enterprise-level lockdown, deploy NextDNS via MDM profile that cannot be removed.

---

## Troubleshooting

### Check NextDNS status

```bash
sudo nextdns status
sudo nextdns log
```

### Restart NextDNS

```bash
sudo nextdns restart
```

### Change config ID

```bash
sudo nextdns config set -config NEW_CONFIG_ID
sudo nextdns restart
```

### Completely remove NextDNS

```bash
sudo nextdns uninstall
```

---

[← Back to Device Lockdown Overview](DEVICE-LOCKDOWN.md)
