import { inject, injectable } from "tsyringe";
import { IUser } from "../interfaces/IUser.js";
import { UserRepository } from "../repository/user.repository.js";
import { compare, hash } from "../utils/hash.js";

@injectable()
export class UserService {
  constructor(
    @inject(UserRepository) private readonly userRepository: UserRepository
  ) {}

  async create(data: Partial<IUser>): Promise<IUser> {
    return this.userRepository.create(data as IUser);
  }

  async findAll(): Promise<IUser[]> {
    return this.userRepository.findAll();
  }

  async findById(id: string): Promise<IUser | null> {
    return this.userRepository.findById(id);
  }

  async update(id: string, data: Partial<IUser>): Promise<IUser | null> {
    return this.userRepository.update(id, data);
  }

  async delete(id: string): Promise<IUser | null> {
    return this.userRepository.delete(id);
  }

  async findByEmail(email: string): Promise<IUser | null> {
    return this.userRepository.findByEmail(email);
  }

  async findByName(name: string): Promise<IUser | null> {
    return this.userRepository.findByName(name);
  }

  async searchUsers(currentUserId: string, nameIdx: string): Promise<IUser[]> {
    return this.userRepository.search(currentUserId, nameIdx);
  }

  // Business Logic Methods

  async register(data: any): Promise<IUser> {
    const { email, password, name } = data;
    const existingUser = await this.userRepository.findByEmail(email);
    if (existingUser) {
      const error: any = new Error("Email already exists");
      error.code = 11000;
      throw error;
    }

    const hashedPassword = await hash(password);
    const user = await this.userRepository.create({
      name,
      email,
      password: hashedPassword,
    } as IUser);

    // ensure password is not returned? Mongoose 'select' usually handles specific queries,
    // but create returns the doc. The controller/serializer should handle removing sensitive data
    // or we transform it here.
    // For now returning the doc.
    return user;
  }

  async login(email: string, password: string): Promise<IUser> {
    const user = await this.userRepository.findByEmail(email);
    if (!user) throw new Error("User credential did not match");
    if (!user.password) throw new Error("User credential did not match");

    const isValid = await compare(password, user.password);
    if (!isValid) throw new Error("User credential did not match");

    return user;
  }

  async changePassword(
    userId: string,
    oldPassword: string,
    newPassword: string
  ): Promise<IUser> {
    const user = await this.userRepository.findById(userId);
    if (!user || !user.password) throw new Error("User not found");

    const isValid = await compare(oldPassword, user.password);
    if (!isValid) throw new Error("Old password did not matched");

    if (oldPassword === newPassword)
      throw new Error("Same password can not be used");

    const hashedPassword = await hash(newPassword);
    const updatedUser = await this.userRepository.update(userId, {
      password: hashedPassword,
    });

    if (!updatedUser) throw new Error("Update failed");
    return updatedUser;
  }
}
