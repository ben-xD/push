# iOS tools for push notifications

## Usage
- Create a copy that is already `.gitignore`'d: Run `cp send_ios_example send_ios`
- Make this new file executable: `chmod +x send_ios.sh`
- Modify the script parameters - e.g. Team ID and APNs device token
- Use it to send push notifications:
  - Send background push notifications: Run `./send_ios -b`
  - Send alert push notifications: Run `./send_ios`
