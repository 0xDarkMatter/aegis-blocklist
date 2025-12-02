# iOS / iPadOS Lockdown Guide

[← Back to Device Lockdown Overview](DEVICE-LOCKDOWN.md)

---

## Step 1: Set Up Screen Time With YOUR Secret Passcode

This is the most important step. You will set a passcode that only YOU know.

1. On your child's iPhone/iPad, go to **Settings** → **Screen Time**

2. Tap **Turn On Screen Time**

3. Tap **This is My Child's iPhone** (or iPad)

4. Set age-appropriate content limits (or skip for now)

5. **Create a Screen Time Passcode** - this is YOUR secret code
   - Use something your child won't guess (NOT their birthday, NOT 1234)
   - **NEVER tell your child this passcode**

6. Enter your Apple ID for recovery (in case you forget)

---

## Step 2: Lock Down The Device

With Screen Time enabled:

1. Go to **Settings** → **Screen Time** → **Content & Privacy Restrictions**

2. Turn ON Content & Privacy Restrictions (enter your passcode)

3. Tap **iTunes & App Store Purchases**:
   - **Installing Apps** → **Don't Allow**
   - **Deleting Apps** → **Don't Allow**

4. Tap **Back**, then tap **Passcode Changes** → **Don't Allow**

5. Tap **Account Changes** → **Don't Allow**

**Your child now cannot install or delete apps without your passcode.**

---

## Step 3: Install NextDNS

1. **Temporarily allow app installs:**
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

---

## Step 4: Verify It's Working

1. Open Safari and go to [test.nextdns.io](https://test.nextdns.io)
2. It should show your configuration ID and a green checkmark
3. Try visiting a blocked site to confirm blocking works

**Your child cannot remove NextDNS or the VPN profile without your Screen Time passcode.**

---

## Optional: Additional Settings

### Restrict Safari Settings

1. Screen Time → Content & Privacy Restrictions → Content Restrictions
2. **Web Content** → Limit Adult Websites (or Allowed Websites Only)

### Block VPN Apps by Category

1. Screen Time → Content & Privacy Restrictions → Content Restrictions
2. **Apps** → Set age limit (VPN apps are often 17+)

### Prevent VPN Profile Installation

1. Screen Time → Content & Privacy Restrictions → Allow Changes
2. **VPN Configuration** → Don't Allow

This prevents your child from installing other VPN profiles (but won't affect NextDNS if already installed).

---

## Troubleshooting

### NextDNS keeps disconnecting

1. Settings → General → VPN & Device Management
2. Check NextDNS VPN is listed and enabled
3. Try toggling NextDNS off and on in the app

### Can't remember Screen Time passcode

1. Use your Apple ID to reset it (if you set one up)
2. Or: Settings → Screen Time → Change Screen Time Passcode → Forgot Passcode

### Child figured out the passcode

1. Change it immediately: Screen Time → Change Screen Time Passcode
2. Use a completely different code
3. Don't use patterns like birthdays or sequential numbers

---

[← Back to Device Lockdown Overview](DEVICE-LOCKDOWN.md)
