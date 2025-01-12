import { z } from 'zod';
import { sendAndroid } from './android';
import { config } from './config';
import { sendDarwin } from './darwin';
import { program } from 'commander';

program.name('push')
    .description('Send push notification to iOS and Android devices by their token.')
    .option('-b, --background', 'Send iOS background message', false)
    .option('-i, --ios', 'Send iOS push notification', false)
    .option('-m, --macos', 'Send macOS push notification', false)
    .option('-a, --android', 'Send Android push notification', false)
    .action(async (options) => {
        const runAllPlatforms = !options.ios && !options.macos && !options.android;
        if (runAllPlatforms) {
            console.log("Sending to all devices since no platform was specified");
        }
        if (runAllPlatforms || options.ios) {
            const deviceToken = z.string().parse(config.apple_apns?.ios_device_token);
            await sendDarwin(config.apple_apns, options.background ? "background" : "alert", deviceToken);
        }
        if (runAllPlatforms || options.macos) {
            const deviceToken = z.string().parse(config.apple_apns?.macos_device_token);
            await sendDarwin(config.apple_apns, options.background ? "background" : "alert", deviceToken);
        }
        if (runAllPlatforms || options.android) {
            await sendAndroid(config.google_fcm);
        }
    }).parse();
