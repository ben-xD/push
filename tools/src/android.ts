import { config, GoogleFcmConfig } from './config';
import { cert, initializeApp } from 'firebase-admin/app';
import * as fs from 'fs';
import { Message, getMessaging } from 'firebase-admin/messaging';

export const sendAndroid = async (config: GoogleFcmConfig | undefined) => {
    if (!config) {
        throw new Error("Missing google_fcm configuration");
    }
    const keyText = fs.readFileSync(config.application_credentials_path).toString();
    const key = JSON.parse(keyText);

    initializeApp({
        credential: cert(key),
    });

    const androidMessage = {
        data: {
            score: "850",
            time: "2:45",
        },
        notification: {
            title: "A daily quote from Android Push Tool",
            body: '"Learn to work harder on yourself than you do on your job. If you work hard on your job you can make a living, but if you work hard on yourself you\'ll make a fortune." - Jim Rohn',
        },
        android: {
            priority: "high",
        },
        token: config.device_registration_token,
    } satisfies Message;

    try {
        const messageId = getMessaging().send(androidMessage);
        console.info("Successfully sent message:", messageId);
    } catch (error) {
        console.error("Error sending message:", error);
    }
}