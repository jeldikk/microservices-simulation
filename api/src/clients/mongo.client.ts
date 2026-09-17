import mongoose from "mongoose";
import { env } from "../env";

export async function connectToDb() {
  try {
    await mongoose.connect(env.MONGO_URI);
    console.log("Connected to MongoDB");
  } catch (error) {
    console.error("Failed to connect to MongoDB", error);
    process.exit(1);
  }
}
