// You can send a push notification with title and text using "Device preview"
// on the firebase console. For example: https://console.firebase.google.com/u/0/project/push-package/notification/compose (That's my firebase project, you should use a different one).

import { cert, initializeApp } from "firebase-admin/app";
import { Message, getMessaging } from "firebase-admin/messaging";
import { z } from "zod";
import * as fs from "fs";
import "dotenv/config";

const envValidator = z.object({
  GOOGLE_APPLICATION_CREDENTIALS: z.string().min(1),
  FCM_REGISTRATION_TOKEN: z.string().min(1),
});
const env = envValidator.parse(process.env);

const keyText = fs.readFileSync(env.GOOGLE_APPLICATION_CREDENTIALS).toString();
const key = JSON.parse(keyText);

initializeApp({
  credential: cert(key),
});

const message = {
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
  token: env.FCM_REGISTRATION_TOKEN,
} satisfies Message;

getMessaging()
  .send(message)
  .then((messageId) => {
    console.info("Successfully sent message:", messageId);
  })
  .catch((error) => {
    console.error("Error sending message:", error);
  });
