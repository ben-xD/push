// You can send a push notification with title and text using "Device preview"
// on the firebase console. For example: https://console.firebase.google.com/u/0/project/push-package/notification/compose (That's my firebase project, you should use a different one).

import { load } from "https://deno.land/std@0.196.0/dotenv/mod.ts";
import { cert, initializeApp } from "npm:firebase-admin/app";
import { getMessaging } from "npm:firebase-admin/messaging";
import { z } from "zod";

const envValidator = z.object({
  GOOGLE_APPLICATION_CREDENTIALS: z.string().min(1),
  FCM_REGISTRATION_TOKEN: z.string().min(1),
});
const env = envValidator.parse(await load());

const keyText = await Deno.readTextFile(env.GOOGLE_APPLICATION_CREDENTIALS);
const key = JSON.parse(keyText);
key.private_key;

initializeApp({
  credential: cert(key),
});

const message = {
  data: {
    score: "850",
    time: "2:45",
  },
  token: env.FCM_REGISTRATION_TOKEN,
};

getMessaging()
  .send(message)
  .then((messageId) => {
    console.info("Successfully sent message:", messageId);
  })
  .catch((error) => {
    console.error("Error sending message:", error);
  });
