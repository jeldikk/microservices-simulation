import dotenv from "dotenv";
dotenv.config();
import { env } from "./env";
import app from "./app";
import { connectToDb } from "./clients/mongo.client";

async function startServer() {
  try {
    console.log(`Connecting to MongoDB at ${env.MONGO_URI}...`);
    await connectToDb();
    console.log("Starting API server...");
    app.listen(env.PORT, () => {
      console.log(`API server listening on port ${env.PORT}`);
    });
  } catch (error) {
    console.error("Failed to start server:", error);
    process.exit(1);
  }
}

startServer();

process.on("unhandledRejection", (reason) => {
  console.error("Unhandled Rejection at reason:", reason);
  process.exit(1);
});

process.on("uncaughtException", (error) => {
  console.error("Uncaught Exception:", error);
  process.exit(1);
});

process.on("SIGTERM", () => {
  console.log("SIGTERM signal received. Shutting down gracefully...");
  process.exit(0);
});
