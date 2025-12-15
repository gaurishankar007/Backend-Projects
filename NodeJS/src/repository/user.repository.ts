import { singleton } from "tsyringe";
import { IUser } from "../interfaces/IUser.js";
import UserModel from "../models/user.model.js";
import { GenericRepository } from "./generic.repository.js";

@singleton()
export class UserRepository extends GenericRepository<IUser> {
  constructor() {
    super(UserModel);
  }

  async findByEmail(email: string): Promise<IUser | null> {
    return this.model.findOne({ email }).exec();
  }

  async findByName(name: string): Promise<IUser | null> {
    return this.model.findOne({ name }).exec();
  }

  async search(excludeId: string, nameRegex: string): Promise<IUser[]> {
    return this.model
      .find({
        _id: { $ne: excludeId },
        name: { $regex: nameRegex, $options: "i" },
      })
      .exec();
  }
}
