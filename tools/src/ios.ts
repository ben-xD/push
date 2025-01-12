import { createSign } from 'crypto';
import { AppleApnsConfig } from './config';
import { fetch } from 'fetch-h2'
import { readFileSync } from 'fs';

export type ApnsMessage = {
    aps: {
        "content-available"?: number;
        alert?: {
            title: string;
            body: string;
        }
        [key: string]: unknown;
    }
}

const base64URLSafe = (input: string): string => {
    return Buffer.from(input)
        .toString('base64')
        .replace(/\+/g, '-')
        .replace(/\//g, '_')
        .replace(/=/g, '');
};

const sign = (input: string, secretKeyPath: string): string => {
    const key = readFileSync(secretKeyPath, 'utf8');
    const signer = createSign('sha256');
    signer.update(input);
    return signer.sign(key, "base64url");
};

const generateJWT = (keyId: string, teamId: string, secretKeyPath: string): string => {
    // your header section
    //
    // e.g.
    // {
    // "alg" : "ES256",
    // "kid" : "ABC123DEFG"
    // }
    const header = base64URLSafe(JSON.stringify({ alg: 'ES256', kid: keyId }));
    const timeS = Math.floor(Date.now() / 1000);
    // const timeS = 1736640894;
    // your claims section
    //
    // e.g.
    // {
    // "iss": "DEF123GHIJ",
    // "iat": 1437179036
    // }
    const claims = base64URLSafe(JSON.stringify({
        iss: teamId,
        iat: timeS
    }));

    const signature = sign(`${header}.${claims}`, secretKeyPath);
    return `${header}.${claims}.${signature}`;
};

export const sendIos = async (config: AppleApnsConfig | undefined, messageType: "background" | "alert") => {
    const isBackground = messageType === "background";
    if (!config) {
        throw new Error("Missing apple_apns configuration");
    }

    const message: ApnsMessage = {
        "aps": {
            "content-available": 1,
            "extraData": "The actual date is unknown."
        }
    };
    if (messageType === "alert") {
        message["aps"]["alert"] = {
            "title": "This title was set in a JSON file",
            "body": "Did you know that JSON was created by Douglas Crockford in 2000"
        }
    }

    const baseUrl = config.is_sandbox ?
        'https://api.sandbox.push.apple.com' :
        'https://api.push.apple.com';
    const url = `${baseUrl}/3/device/${config.device_token}`;
    const jwt = generateJWT(config.key_id, config.team_id, config.key_path);

    const response = await fetch(url, {
        method: 'POST',
        headers: {
            'authorization': `bearer ${jwt}`,
            'apns-topic': config.bundle_id,
            'apns-push-type': isBackground ? 'background' : 'alert',
            'apns-priority': isBackground ? '5' : '10',
        },
        body: JSON.stringify(message)
    });
    return await response.text();
}