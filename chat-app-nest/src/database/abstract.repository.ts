import { Document, Model, QueryFilter, UpdateQuery } from 'mongoose';

export abstract class AbstractRepository<T extends Document> {
  constructor(protected readonly model: Model<T>) {}

  async create(document: Partial<T>): Promise<T> {
    const createdDocument = new this.model(document);
    return (await createdDocument.save()) as unknown as T;
  }

  async findAll(): Promise<T[]> {
    return (await this.model.find().exec()) as unknown as T[];
  }

  async findById(id: string): Promise<T | null> {
    return (await this.model.findById(id).exec()) as unknown as T | null;
  }

  async findOne(queryFilter: QueryFilter<T>): Promise<T | null> {
    return (await this.model
      .findOne(queryFilter)
      .exec()) as unknown as T | null;
  }

  async update(id: string, updateQuery: UpdateQuery<T>): Promise<T | null> {
    return (await this.model
      .findByIdAndUpdate(id, updateQuery, { new: true })
      .exec()) as unknown as T | null;
  }

  async delete(id: string): Promise<T | null> {
    return (await this.model
      .findByIdAndDelete(id)
      .exec()) as unknown as T | null;
  }

  async findAllPaginatedWithFilter(
    filter: QueryFilter<T>,
    page: number,
    limit: number,
  ): Promise<T[]> {
    return (await this.model
      .find(filter)
      .skip((page - 1) * limit)
      .limit(limit)
      .exec()) as unknown as T[];
  }
}
