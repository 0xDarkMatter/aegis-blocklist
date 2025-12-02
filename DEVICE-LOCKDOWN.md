# Device Lockdown Guide

**How to prevent your child from bypassing DNS filtering**

Installing a DNS filter isn't enough. Kids can uninstall apps, change settings, or find workarounds. This guide shows you how to lock down each device so they can't undo your work.

---

## The Golden Rule

| Account Type | Who Uses It | Can Change Settings? |
|--------------|-------------|---------------------|
| **Administrator / Parent** | YOU | Yes - full control |
| **Standard / Child** | YOUR CHILD | No - cannot install or remove apps |

**If your child knows the admin password or has admin rights, none of this works. They can undo everything.**

---

## Windows

### Step 1: Create Separate Accounts

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

### Step 2: Get Your NextDNS Configuration ID

Before installing, you need your NextDNS config ID:

1. Go to [my.nextdns.io](https://my.nextdns.io) and sign up (free)
2. Your **Configuration ID** is shown at the top - it looks like `abc123` (6-7 characters)
3. Write this down - you'll need it in the next step

### Step 3: Install NextDNS CLI (The Easy Way)

**Option A: Windows Installer (Recommended)**

1. Log into YOUR admin account (not your child's)
2. Download the installer: [nextdns.io/download/windows/stable](https://nextdns.io/download/windows/stable)
3. Run the installer
4. When prompted, enter your **Configuration ID** from Step 2
5. Click Install - it runs as a Windows Service automatically

**Option B: Command Line**

1. Log into YOUR admin account
2. Download `nextdns_windows_amd64.zip` from [github.com/nextdns/nextdns/releases](https://github.com/nextdns/nextdns/releases)
3. Extract to `C:\Program Files\NextDNS\`
4. Open **Command Prompt as Administrator** (right-click → Run as administrator)
5. Run these commands (replace `abc123` with YOUR config ID):

```cmd
cd "C:\Program Files\NextDNS"
nextdns.exe install -config abc123 -report-client-info -auto-activate
```

### Step 4: Verify It's Working

1. Open Command Prompt and run:
```cmd
nslookup google.com
```
2. The server should show `127.0.0.1` - this means NextDNS is active
3. Visit [test.nextdns.io](https://test.nextdns.io) in a browser - it should show your config ID

### Step 5: Test That Your Child Can't Remove It

1. Log out of your admin account
2. Log into your CHILD'S standard account
3. Try to uninstall NextDNS - it should require admin password
4. Try to stop the service - it should fail

**Your child cannot uninstall or disable NextDNS without your admin password.**

---

## macOS

### Step 1: Create Separate Accounts

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

### Step 2: Get Your NextDNS Configuration ID

1. Go to [my.nextdns.io](https://my.nextdns.io) and sign up (free)
2. Your **Configuration ID** is at the top - looks like `abc123`
3. Write this down

### Step 3: Install NextDNS CLI

**Option A: Using Homebrew (if you have it)**

1. Log into YOUR admin account
2. Open **Terminal** (Applications → Utilities → Terminal)
3. Run these commands (replace `abc123` with YOUR config ID):

```bash
brew install nextdns/tap/nextdns
sudo nextdns install -config abc123 -report-client-info
sudo nextdns activate
```

4. Enter your password when prompted

**Option B: Direct Install (no Homebrew)**

1. Log into YOUR admin account
2. Open **Terminal**
3. Run this one-liner:

```bash
sh -c 'sh -c "$(curl -sL https://nextdns.io/install)"'
```

4. Follow the prompts - enter your Configuration ID when asked
5. Enter your password when prompted

### Step 4: Verify It's Working

In Terminal, run:
```bash
sudo nextdns status
```

It should show "running". Also visit [test.nextdns.io](https://test.nextdns.io).

### Step 5: Enable Screen Time (Extra Protection)

1. System Settings → **Screen Time**
2. Select your child's account
3. Turn on **Content & Privacy Restrictions**
4. Set a Screen Time passcode (different from your login password)
5. Under "Content & Privacy" → restrict app installations

---

## iOS / iPadOS

### Step 1: Set Up Screen Time With YOUR Secret Passcode

This is the most important step. You will set a passcode that only YOU know.

1. On your child's iPhone/iPad, go to **Settings** → **Screen Time**
2. Tap **Turn On Screen Time**
3. Tap **This is My Child's iPhone** (or iPad)
4. Set age-appropriate content limits (or skip for now)
5. **Create a Screen Time Passcode** - this is YOUR secret code
   - Use something your child won't guess (NOT their birthday, NOT 1234)
   - **NEVER tell your child this passcode**
6. Enter your Apple ID for recovery (in case you forget)

### Step 2: Lock Down The Device

With Screen Time enabled:

1. Go to **Settings** → **Screen Time** → **Content & Privacy Restrictions**
2. Turn ON Content & Privacy Restrictions (enter your passcode)
3. Tap **iTunes & App Store Purchases**:
   - **Installing Apps** → **Don't Allow**
   - **Deleting Apps** → **Don't Allow**
4. Tap **Back**, then tap **Passcode Changes** → **Don't Allow**
5. Tap **Account Changes** → **Don't Allow**

**Your child now cannot install or delete apps without your passcode.**

### Step 3: Install NextDNS

1. Temporarily allow app installs:
   - Settings → Screen Time → Content & Privacy → iTunes & App Store Purchases
   - Enter your passcode
   - Set "Installing Apps" to **Allow**

2. Open the **App Store** and search for **NextDNS**
3. Install the app (it's free)
4. Open NextDNS and tap **Get Started**
5. Enter your Configuration ID (from [my.nextdns.io](https://my.nextdns.io))
6. Tap **Enable NextDNS** → Allow the VPN configuration
7. Toggle NextDNS ON

8. **Re-disable app installs immediately:**
   - Settings → Screen Time → Content & Privacy → iTunes & App Store Purchases
   - Set "Installing Apps" back to **Don't Allow**

### Step 4: Verify It's Working

1. Open Safari and go to [test.nextdns.io](https://test.nextdns.io)
2. It should show your configuration ID and a green checkmark
3. Try visiting a blocked site to confirm blocking works

**Your child cannot remove NextDNS or the VPN profile without your Screen Time passcode.**

---

## Android

### Step 1: Set Up Google Family Link

Family Link lets you control your child's phone FROM YOUR phone.

**On YOUR phone (parent):**
1. Download **Google Family Link for parents** from Play Store
2. Open it and sign in with your Google account
3. Tap **Get Started** → follow the setup

**On your CHILD'S phone:**
1. Make sure your child is signed in with their own Google account
2. Open **Settings** → **Google** → **Parental Controls**
3. Or download **Family Link for children & teens** from Play Store
4. Follow the prompts to link to your parent account

### Step 2: Require Approval for App Installs

On YOUR phone in Family Link:

1. Open **Family Link**
2. Select your child
3. Tap **Controls** → **Google Play**
4. Set **Require approval for** → **All content**

**Your child now cannot install ANY app without you approving it on your phone.**

### Step 3: Install NextDNS

1. On your CHILD'S phone, open **Play Store**
2. Search for **NextDNS** and tap Install
3. You'll get a notification on YOUR phone - tap **Approve**
4. Once installed, open NextDNS on your child's phone
5. Tap **Get Started**
6. Enter your Configuration ID (from [my.nextdns.io](https://my.nextdns.io))
7. Tap **Enable NextDNS** → Allow the VPN configuration
8. Toggle NextDNS ON

### Step 4: Verify It's Working

On your child's phone:
1. Open Chrome and go to [test.nextdns.io](https://test.nextdns.io)
2. It should show your configuration ID

### Step 5: Block NextDNS From Being Uninstalled

On YOUR phone in Family Link:
1. Open **Family Link** → select your child
2. Go to **Controls** → **Apps**
3. Find **NextDNS** in the list
4. Make sure it's not blocked (so it keeps running)

**Your child cannot uninstall NextDNS without your approval.**

---

## Chromebook

### Step 1: Set Up a Supervised Google Account

1. On your computer, go to [families.google.com](https://families.google.com)
2. Click **Create a family** (if you haven't already)
3. Add your child's Google account to your family
4. Turn on supervision for their account

### Step 2: Sign Your Child Into the Chromebook

1. On the Chromebook, sign OUT of any existing account
2. Click **Add person** or **Sign in**
3. Sign in with your CHILD'S supervised Google account (not yours)

### Step 3: Configure via Family Link

On YOUR phone:
1. Open **Family Link**
2. Select your child → **Controls**
3. Under **Chrome settings**, restrict sites as needed
4. Under **Apps**, require approval for extensions

### Step 4: Set NextDNS at Router Level

Chromebooks don't support the NextDNS app directly. Options:

**Option A: Configure NextDNS on your router**
- This affects all devices on your network
- See your router's manual for DNS settings
- Set DNS to: `45.90.28.0` and `45.90.30.0` (with your config ID in the path)

**Option B: Use NextDNS DNS-over-HTTPS in Chrome**
1. On the Chromebook, open Chrome
2. Go to **Settings** → **Privacy and security** → **Security**
3. Enable **Use secure DNS**
4. Select **Custom** and enter:
   ```
   https://dns.nextdns.io/abc123
   ```
   (Replace `abc123` with your config ID)

**Note:** School Chromebooks are managed by the school. Contact their IT department about home filtering.

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
3. Review this guide to ensure proper lockdown

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
