import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { AbstractRepository } from '../../database/abstract.repository';
import { User, UserDocument } from './schemas/user.schema';

@Injectable()
export class UserRepository extends AbstractRepository<UserDocument> {
  constructor(@InjectModel(User.name) userModel: Model<UserDocument>) {
    super(userModel);
  }

  // Custom method specific to User
  async searchUsers(keyword: string, currentUserId: string): Promise<User[]> {
    const regex = new RegExp(keyword, 'i');
    return (await this.model.find({
      $or: [{ name: regex }, { email: regex }],
      _id: { $ne: currentUserId },
    })) as unknown as User[];
  }

  async findByEmailWithPassword(email: string): Promise<UserDocument | null> {
    return (await this.model
      .findOne({ email })
      .select('+password')
      .exec()) as unknown as UserDocument | null;
  }
}
