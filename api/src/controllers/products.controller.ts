import { Request, Response } from "express";
import { ProductModel } from "../models/products.model";
import { redisClient } from "../clients/redis.client";

export async function getProducts(req: Request, res: Response) {
  try {
    const products = await ProductModel.find();
    res.status(200).json(products);
  } catch (error) {
    res.status(500).json({ message: "Failed to fetch products", error });
  }
}

export async function getProductsWithCache(req: Request, res: Response) {
  try {
    // check if items are present in cache
    const cachedProducts = await redisClient.get("products");
    if (cachedProducts) {
      await redisClient.lpush("cache:hit", `${new Date().toISOString()}`);
      // if it is a cache hit, return the cached products immediately
      return res.status(200).json(JSON.parse(cachedProducts));
    }
    const products = await ProductModel.find();
    // if cache miss, store the products in cache
    await redisClient.setex("products", 30, JSON.stringify(products));
    await redisClient.lpush("cache:miss", `${new Date().toISOString()}`);
    res.status(200).json(products);
  } catch (error) {
    res
      .status(500)
      .json({ message: "Failed to fetch products with cache", error });
  }
}

export async function getProductById(req: Request, res: Response) {
  try {
    const product = await ProductModel.findById(req.params.id);
    if (!product) {
      return res.status(404).json({ message: "Product not found" });
    }
    res.status(200).json(product);
  } catch (error) {
    res.status(500).json({ message: "Failed to fetch product", error });
  }
}

export async function seedProducts(req: Request, res: Response) {
  try {
    // remove cache keys if exists
    await redisClient.del("products");
    await redisClient.del("cache:hit");
    await redisClient.del("cache:miss");
    // Logic to seed products goes here
    const createdProducts = await ProductModel.insertMany([
      {
        name: "Product 1",
        price: 100,
        description: "Description 1",
        category: "Category 1",
      },
      {
        name: "Product 2",
        price: 200,
        description: "Description 2",
        category: "Category 2",
      },
      {
        name: "Product 3",
        price: 300,
        description: "Description 3",
        category: "Category 3",
      },
      {
        name: "Product 4",
        price: 400,
        description: "Description 4",
        category: "Category 4",
      },
      {
        name: "Product 5",
        price: 500,
        description: "Description 5",
        category: "Category 5",
      },
      {
        name: "Product 6",
        price: 600,
        description: "Description 6",
        category: "Category 6",
      },
    ]);
    res.status(201).json({
      message: "Products seeded successfully",
      productIds: createdProducts.map((product) => product._id),
    });
  } catch (error) {
    res.status(500).json({ message: "Failed to seed products", error });
  }
}
