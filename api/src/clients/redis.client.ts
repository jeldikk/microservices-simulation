import Redis from "ioredis";

export const redisClient = new Redis({
  host: "redis", // The name of the Redis service in your docker-compose.yml
  port: 6379,
});

redisClient.on("error", (err) => {
  console.error("Redis error:", err);
});

redisClient.on("connect", () => {
  console.log("Connected to Redis");
});

redisClient.on("ready", () => {
  console.log("Redis client is ready");
});

redisClient.on("end", () => {
  console.log("Redis connection closed");
});

redisClient.on("reconnecting", () => {
  console.log("Redis client is reconnecting");
});
