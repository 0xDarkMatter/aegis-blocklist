# Android Lockdown Guide

[← Back to Device Lockdown Overview](DEVICE-LOCKDOWN.md)

---

## Step 1: Set Up Google Family Link

Family Link lets you control your child's phone FROM YOUR phone.

### On YOUR phone (parent):

1. Download **Google Family Link for parents** from Play Store
2. Open it and sign in with your Google account
3. Tap **Get Started** → follow the setup

### On your CHILD'S phone:

1. Make sure your child is signed in with their own Google account
2. Open **Settings** → **Google** → **Parental Controls**
3. Or download **Family Link for children & teens** from Play Store
4. Follow the prompts to link to your parent account

---

## Step 2: Require Approval for App Installs

On YOUR phone in Family Link:

1. Open **Family Link**
2. Select your child
3. Tap **Controls** → **Google Play**
4. Set **Require approval for** → **All content**

**Your child now cannot install ANY app without you approving it on your phone.**

---

## Step 3: Install NextDNS

1. On your CHILD'S phone, open **Play Store**

2. Search for **NextDNS** and tap Install

3. You'll get a notification on YOUR phone - tap **Approve**

4. Once installed, open NextDNS on your child's phone

5. Tap **Get Started**

6. Enter your Configuration ID (from [my.nextdns.io](https://my.nextdns.io))

7. Tap **Enable NextDNS** → Allow the VPN configuration

8. Toggle NextDNS ON

---

## Step 4: Verify It's Working

On your child's phone:

1. Open Chrome and go to [test.nextdns.io](https://test.nextdns.io)
2. It should show your configuration ID

---

## Step 5: Block NextDNS From Being Uninstalled

On YOUR phone in Family Link:

1. Open **Family Link** → select your child
2. Go to **Controls** → **Apps**
3. Find **NextDNS** in the list
4. Make sure it's not blocked (so it keeps running)

**Your child cannot uninstall NextDNS without your approval.**

---

## Optional: Additional Settings

### Set Screen Time Limits

In Family Link on YOUR phone:
1. Select your child → **Controls** → **Daily limit**
2. Set time limits per day

### Block Specific Apps

1. Family Link → your child → **Controls** → **Apps**
2. Find the app → tap to block

### Location Tracking

1. Family Link → your child → **Location**
2. Enable location sharing

### Bedtime Mode

1. Family Link → your child → **Controls** → **Bedtime**
2. Set device bedtime hours

---

## For Older Teens (Alternative: Private DNS)

If Family Link feels too restrictive for an older teen, you can use Android's built-in Private DNS:

1. Settings → Network & Internet → Private DNS
2. Select "Private DNS provider hostname"
3. Enter: `abc123.dns.nextdns.io` (replace with your config ID)

**Note:** This is easier to bypass than the NextDNS app + Family Link combo.

---

## Troubleshooting

### Family Link setup fails

- Both phones need internet connection
- Child's account must be a child account (under 13) OR you need to supervise an existing account
- Try removing and re-adding the child's Google account

### NextDNS keeps disconnecting

1. Go to Settings → Apps → NextDNS → Battery
2. Set to "Unrestricted" or disable battery optimization
3. Some Android skins (Samsung, Xiaomi) aggressively kill background apps

### Child removed supervision

- This requires parent approval, so you should get a notification
- If they factory reset the phone, you'll need to set up Family Link again

---

[← Back to Device Lockdown Overview](DEVICE-LOCKDOWN.md)
