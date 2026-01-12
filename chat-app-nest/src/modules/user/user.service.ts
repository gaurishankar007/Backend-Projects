import { BadRequestException, Injectable } from '@nestjs/common';
import * as bcrypt from 'bcryptjs';
import { CreateUserDto } from './dto/create-user.dto';
import { UserRepository } from './user.repository';

@Injectable()
export class UserService {
  constructor(private readonly userRepository: UserRepository) {}

  async create(createUserDto: CreateUserDto) {
    const existingUser = await this.userRepository.findOne({
      email: createUserDto.email,
    });
    if (existingUser) {
      throw new BadRequestException('User already exists');
    }
    // Hash password here or in a pre-save hook
    const hashedPassword = await bcrypt.hash(createUserDto.password, 10);
    return this.userRepository.create({
      ...createUserDto,
      password: hashedPassword,
    });
  }

  async search(keyword: string, userId: string) {
    return this.userRepository.searchUsers(keyword, userId);
  }

  async findByEmail(email: string) {
    return this.userRepository.findOne({ email });
  }

  async findByEmailWithPassword(email: string) {
    return await this.userRepository.findByEmailWithPassword(email);
  }

  async findById(id: string) {
    return this.userRepository.findById(id);
  }

  async updateProfile(userId: string, pic: string) {
    return this.userRepository.update(userId, { pic });
  }

  async changePassword(userId: string, oldPass: string, newPass: string) {
    const userDoc = await this.findById(userId);
    if (!userDoc) {
      throw new BadRequestException('User not found');
    }
    const user = await this.userRepository.findByEmailWithPassword(
      userDoc.email,
    );
    if (!user) {
      throw new BadRequestException('User not found');
    }
    const isMatch = await bcrypt.compare(oldPass, user.password);
    if (!isMatch) {
      throw new BadRequestException('Old password does not match');
    }
    const hashedPassword = await bcrypt.hash(newPass, 10);
    return this.userRepository.update(userId, { password: hashedPassword });
  }

  async changeName(userId: string, name: string) {
    return this.userRepository.update(userId, { name });
  }
}
