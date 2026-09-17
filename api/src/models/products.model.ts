import mongoose from "mongoose";
import { IProduct } from "../types/product.type";

const ProductSchema = new mongoose.Schema(
  {
    name: { type: String, required: true },
    price: { type: Number, required: true },
    description: { type: String },
    category: { type: String, required: true },
  },
  {
    timestamps: true,
    versionKey: false,
  },
);

export const ProductModel = mongoose.model<IProduct>("Product", ProductSchema);
