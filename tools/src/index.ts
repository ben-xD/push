import { sendAndroid } from './android';
import { config } from './config';
import { sendIos } from './ios';
import { program } from 'commander';

program.name('push')
    .description('Send push notification to iOS and Android devices by their token.')
    .option('-b, --background', 'Send iOS background message', false)
    .option('-i, --ios', 'Send iOS push notification', false)
    .option('-a, --android', 'Send Android push notification', false)
    .action(async (options) => {
        if (!options.ios && !options.android) {
            console.error('You must specify at least one of --ios or --android');
            process.exit(1);
        }
        if (options.ios) {
            if (options.background) {
                await sendIos(config.apple_apns, "background");
            } else {
                await sendIos(config.apple_apns, "alert");
            }
        }
        if (options.android) {
            await sendAndroid(config.google_fcm);
        }
    });

program.parse();