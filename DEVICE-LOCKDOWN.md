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

**Step 1: You need TWO accounts on the computer**

| Account | Who uses it | Account type | Can change settings? |
|---------|-------------|--------------|---------------------|
| Your account | YOU (the parent) | **Administrator** | Yes - you control everything |
| Child's account | YOUR CHILD | **Standard User** | No - they can't install/uninstall apps |

**How to set this up:**
1. Go to Settings → Accounts → Family & other users
2. Click "Add a family member" → Add your child
3. **CRITICAL:** Click on their account → "Change account type" → select **Standard User**
4. Your child logs into THEIR account. You log into YOUR account to make changes.
5. **NEVER tell your child your admin password**

**Step 2: Install NextDNS while logged into YOUR admin account**
1. Log into YOUR admin account (not your child's account)
2. Install NextDNS CLI - it installs as a system service
3. The filter now works for ALL accounts on the computer
4. Your child cannot uninstall it because they don't have admin rights

**Step 3: Block VPN apps (optional but recommended)**
- Use AppLocker (Windows Pro/Enterprise) to block VPN executables
- Or use Windows Parental Controls to restrict app installs

---

## macOS

**Step 1: You need TWO accounts on the Mac**

| Account | Who uses it | Account type | Can change settings? |
|---------|-------------|--------------|---------------------|
| Your account | YOU (the parent) | **Administrator** | Yes - you control everything |
| Child's account | YOUR CHILD | **Standard** | No - they can't install/uninstall apps |

**How to set this up:**
1. System Preferences → Users & Groups → Click the lock to make changes
2. Click "+" to add a new user
3. Set "New Account" type to **Standard** (NOT Administrator)
4. Enter your child's name and create a password for them
5. Your child logs into THEIR account. You log into YOUR account to make changes.
6. **NEVER tell your child your admin password**

**Step 2: Install NextDNS while logged into YOUR admin account**
1. Log into YOUR admin account (not your child's account)
2. Open Terminal and run:
```bash
brew install nextdns/tap/nextdns
sudo nextdns install -config YOUR_CONFIG_ID
sudo nextdns activate
```
3. This runs as a system daemon - works for ALL accounts on the Mac
4. Your child cannot stop or uninstall it because they don't have admin rights

**Step 3: Enable Screen Time restrictions**
1. System Preferences → Screen Time
2. Click on your child's account
3. Turn on Content & Privacy → restrict app installs and system changes

---

## iOS / iPadOS

**The key concept: Screen Time Passcode**

On iPhones/iPads, YOU control the device using a **Screen Time Passcode** that only you know. Your child uses the device but cannot change settings without this passcode.

| Who | What they know |
|-----|----------------|
| YOU (the parent) | The Screen Time Passcode (4-6 digits) |
| YOUR CHILD | Nothing - they can use the device but not change settings |

**Step 1: Set up Screen Time with YOUR secret passcode**
1. On your child's iPhone/iPad: Settings → Screen Time
2. Tap "Turn On Screen Time"
3. Tap "This is My Child's iPhone/iPad"
4. Set a **Screen Time Passcode** - this is YOUR secret code, **NEVER tell your child**
5. Choose a code your child won't guess (not their birthday, not 1234)

**Step 2: Lock down the device so your child can't undo your settings**
1. Screen Time → Content & Privacy Restrictions → Turn ON
2. Go to "iTunes & App Store Purchases":
   - Installing Apps → **Don't Allow** (prevents VPN app installs)
   - Deleting Apps → **Don't Allow** (prevents removing NextDNS)
3. Go to "Allow Changes":
   - Account Changes → **Don't Allow**
   - Cellular Data Changes → **Don't Allow**
   - DNS Settings → **Don't Allow** (if available)

**Step 3: Install NextDNS**
1. Temporarily allow app installs (you'll need your Screen Time Passcode)
2. Download NextDNS from App Store, configure with your profile ID
3. Disable app installs again
4. The NextDNS profile cannot be removed without your Screen Time Passcode

---

## Android

**The key concept: Google Family Link**

On Android, YOU control your child's device using **Google Family Link** - an app on YOUR phone that manages THEIR phone.

| Device | Who controls it | App needed |
|--------|-----------------|------------|
| YOUR phone | You | Family Link (Parent version) |
| CHILD'S phone | You (remotely) | Family Link (Child version) - locked |

**Step 1: Set up Family Link (recommended for all ages)**
1. On YOUR phone: Download "Google Family Link for Parents" from Play Store
2. On YOUR CHILD'S phone: Sign in with a Google account you supervise
3. Follow the setup - you'll link the two phones together
4. **Your child cannot remove Family Link without your approval**

**Step 2: Configure Family Link controls**
1. Open Family Link on YOUR phone
2. Select your child's device
3. Go to "Controls" → "Apps" → require approval for all app installs
4. This means your child CANNOT install VPN apps without you approving it

**Step 3: Install NextDNS on your child's phone**
1. On your child's phone, go to Play Store → search "NextDNS"
2. You'll get a notification on YOUR phone to approve the install - approve it
3. Configure NextDNS with your profile ID
4. Your child cannot uninstall NextDNS without your approval

**For older teens (if Family Link feels too restrictive):**
- You can use a separate user account on the phone
- But Family Link is more secure and harder to bypass

---

## Chromebook

**The key concept: Supervised Google Account**

Chromebooks are controlled by Google accounts. Your child signs in with a supervised account that YOU control.

| Account | Who uses it | Who controls it |
|---------|-------------|-----------------|
| Your Google account | You | You |
| Child's supervised account | Your child | You (via Family Link) |

**Step 1: Set up a supervised account for your child**
1. Go to [families.google.com](https://families.google.com) on your computer
2. Create a supervised Google account for your child (or supervise their existing one)
3. This links to your Google Family Link

**Step 2: Sign your child into the Chromebook with THEIR supervised account**
1. On the Chromebook, sign in with your child's supervised Google account
2. NOT your account - they should have their own

**Step 3: Configure restrictions via Family Link**
1. On YOUR phone, open Google Family Link
2. Select your child → "Controls"
3. Manage Chrome settings, apps, and screen time
4. Your child cannot install Chrome extensions or change DNS settings

**Note:** School Chromebooks may already be managed by the school. Check with the school's IT department about home DNS filtering.

---

## Remember

The best technical controls can be defeated if your child has admin access or knows your passwords.

- **Keep credentials secret** - never share admin passwords or Screen Time passcodes
- **Audit regularly** - check that settings haven't been changed
- **Talk to your kids** - technical controls are part of a broader conversation about online safety
