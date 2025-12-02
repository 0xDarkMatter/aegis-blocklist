# Windows Lockdown Guide

[← Back to Device Lockdown Overview](DEVICE-LOCKDOWN.md)

---

## Step 1: Create Separate Accounts

You need TWO accounts on the computer:

| Account | Who uses it | Account type |
|---------|-------------|--------------|
| Your account | YOU (the parent) | **Administrator** |
| Child's account | YOUR CHILD | **Standard User** |

**How to set this up:**

1. Press `Windows + I` to open Settings
2. Go to **Accounts** → **Family & other users**
3. Click **Add a family member** → Add your child
4. **CRITICAL:** Click on their account → **Change account type** → select **Standard User**
5. **NEVER tell your child your admin password**

---

## Step 2: Get Your NextDNS Configuration ID

Before installing, you need your NextDNS config ID:

1. Go to [my.nextdns.io](https://my.nextdns.io) and sign up (free)
2. Your **Configuration ID** is shown at the top - it looks like `abc123` (6-7 characters)
3. Write this down - you'll need it in the next step

---

## Step 3: Install NextDNS CLI

> **Important:** There are two NextDNS apps for Windows:
> - **GUI app** (from nextdns.io) - has a tray icon your child can right-click to disable
> - **CLI** (from GitHub) - runs as an invisible Windows Service, no tray icon
>
> **For child safety, use the CLI.** It's invisible and requires admin rights to stop.

1. Log into YOUR admin account (not your child's)

2. Download the CLI from [github.com/nextdns/nextdns/releases](https://github.com/nextdns/nextdns/releases)
   - Get `nextdns_X.XX.X_windows_amd64.zip` (the latest version)

3. Extract the zip file

4. Move `nextdns.exe` to `C:\Program Files\NextDNS\` (create this folder)

5. Open **Command Prompt as Administrator**:
   - Press `Windows` key, type `cmd`
   - Right-click **Command Prompt** → **Run as administrator**

6. Run these commands (replace `abc123` with YOUR config ID from Step 2):

```cmd
cd "C:\Program Files\NextDNS"
nextdns.exe install -config abc123 -report-client-info -auto-activate
```

7. You should see "NextDNS installed and started"

**That's it.** NextDNS now runs as a Windows Service with no tray icon. Your child won't see it running and cannot disable it without admin rights.

---

## Step 4: Verify It's Working

1. Open Command Prompt and run:
```cmd
nslookup google.com
```

2. The server should show `127.0.0.1` - this means NextDNS is active

3. Visit [test.nextdns.io](https://test.nextdns.io) in a browser - it should show your config ID

---

## Step 5: Test That Your Child Can't Remove It

1. Log out of your admin account
2. Log into your CHILD'S standard account
3. Try to uninstall NextDNS - it should require admin password
4. Try to stop the service - it should fail

**Your child cannot uninstall or disable NextDNS without your admin password.**

---

## Optional: Additional Hardening

### Block VPN Apps with AppLocker (Windows Pro/Enterprise)

1. Open **Local Security Policy** (`secpol.msc`)
2. Go to **Application Control Policies** → **AppLocker**
3. Create rules to block common VPN executables

### Use Windows Family Safety

1. Go to [family.microsoft.com](https://family.microsoft.com)
2. Add your child's Microsoft account
3. Enable activity reporting and screen time limits

---

## Troubleshooting

### NextDNS service won't start

```cmd
# Check service status
sc query nextdns

# Try starting manually
net start nextdns

# Check logs
eventvwr.msc → Windows Logs → Application
```

### Need to change config ID

```cmd
cd "C:\Program Files\NextDNS"
nextdns.exe uninstall
nextdns.exe install -config NEW_CONFIG_ID -report-client-info -auto-activate
```

### Completely remove NextDNS

```cmd
cd "C:\Program Files\NextDNS"
nextdns.exe uninstall
```

---

[← Back to Device Lockdown Overview](DEVICE-LOCKDOWN.md)
