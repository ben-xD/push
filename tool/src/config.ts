import { z } from "zod";
import fs from "fs";
import yaml from "yaml";

export const GoogleFcmConfig = z.object({
    application_credentials_path: z.string(),
    device_registration_token: z.string(),
});
export type GoogleFcmConfig = z.infer<typeof GoogleFcmConfig>;

export const AppleApnsConfig = z.object({
    team_id: z.string(),
    key_id: z.string(),
    key_path: z.string(),
    bundle_id: z.string(),
    ios_device_token: z.string().optional(),
    macos_device_token: z.string().optional(),
    is_sandbox: z.boolean().default(true),
});
export type AppleApnsConfig = z.infer<typeof AppleApnsConfig>;

// 1. Define a schema that matches the YAML structure
export const configSchema = z.object({
    google_fcm: GoogleFcmConfig.optional(),
    apple_apns: AppleApnsConfig.optional(),
});

// 2. Derive the TypeScript type from the schema
export type Config = z.infer<typeof configSchema>;

/**
 * Reads and parses a YAML file, then validates the resulting data
 * against the configSchema. Throws an error if validation fails.
 */
export function loadConfig(path: string): Config {
    const fileContent = fs.readFileSync(path, "utf-8");
    const data = yaml.parse(fileContent);

    // Validate and return the typed config
    return configSchema.parse(data);
}

export const config = loadConfig("config.yaml");