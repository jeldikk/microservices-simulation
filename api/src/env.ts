import z from "zod";
import dotenv from "dotenv";

dotenv.config();

const envSchema = z.object({
  PORT: z.string().default("3000"),
  MONGO_URI: z.string().default("mongodb://localhost:27017"),
});

export const env = envSchema.parse(process.env);
