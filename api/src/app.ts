import express, { NextFunction, Request, Response } from "express";
import morgan from "morgan";
import productRouter from "./routers/product.router";
import client from "prom-client";

const app = express();

const registry = new client.Registry();
client.collectDefaultMetrics({ register: registry });

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(morgan("dev"));

const httpRequestDurationMicroseconds = new client.Histogram({
  name: "http_request_duration_seconds",
  help: "Duration of HTTP requests in seconds",
  labelNames: ["method", "route", "status_code"],
  buckets: [0.1, 0.3, 0.5, 0.7, 1, 3, 5, 10],
});
registry.registerMetric(httpRequestDurationMicroseconds);

// 4. Middleware to time all incoming requests
app.use((req, res, next) => {
  const end = httpRequestDurationMicroseconds.startTimer();
  res.on("finish", () => {
    // Collect route path or fallback to originalUrl
    const route = req.route ? req.route.path : req.originalUrl;
    end({ method: req.method, route, status_code: res.statusCode });
  });
  next();
});

app.get("/api/health", (_req: Request, res: Response) => {
  res.status(200).json({ status: "ok" });
});

app.use("/api/products", productRouter);

app.get("/api/metrics", async (_req: Request, res: Response) => {
  res.setHeader("Content-Type", registry.contentType);
  res.end(await registry.metrics());
});

app.use((req: Request, res: Response, next: NextFunction) => {
  res.status(404).json({ message: "Not Found" });
});

app.use((err: any, req: Request, res: Response, next: NextFunction) => {
  console.error(err);
  res.status(500).json({ message: "Internal Server Error", error: err });
});

export default app;
