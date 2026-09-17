import express from "express";
import {
  seedProducts,
  getProducts,
  getProductsWithCache,
  getProductById,
} from "../controllers/products.controller";
const router = express.Router();

router.get("/", getProducts);
router.get("/cache", getProductsWithCache);
router.post("/seed", seedProducts);
router.get("/:id", getProductById);

export default router;
