import mongoose from "mongoose";
import { BaseRepository } from "./base.repository.js";

export class GenericRepository<T extends mongoose.Document>
  implements BaseRepository<T>
{
  protected readonly model: mongoose.Model<T>;

  constructor(model: mongoose.Model<T>) {
    this.model = model;
  }

  async create(data: Partial<T>): Promise<T> {
    return this.model.create(data as T);
  }

  async findAll(): Promise<T[]> {
    return this.model.find().exec();
  }

  async findById(id: string): Promise<T | null> {
    return this.model.findById(id).exec();
  }

  async update(id: string, data: Partial<T>): Promise<T | null> {
    return this.model.findByIdAndUpdate(id, data as any, { new: true }).exec();
  }

  async delete(id: string): Promise<T | null> {
    return this.model.findByIdAndDelete(id).exec();
  }

  async findAllPaginatedWithFilter(
    filter: any,
    page: number,
    limit: number
  ): Promise<T[]> {
    return this.model
      .find(filter)
      .skip((page - 1) * limit)
      .limit(limit)
      .exec();
  }
}
