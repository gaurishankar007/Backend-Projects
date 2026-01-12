import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcryptjs';
import { UserService } from '../user/user.service';

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UserService,
    private readonly jwtService: JwtService,
  ) {}

  async login(email: string, pass: string) {
    const user = await this.userService.findByEmailWithPassword(email);
    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }

    const isMatch = await bcrypt.compare(pass, user.password);
    if (!isMatch) {
      throw new UnauthorizedException('Invalid credentials');
    }

    const payload = { email: user.email, id: user._id };
    return {
      access_token: this.jwtService.sign(payload),
      user: {
        _id: user._id,
        name: user.name,
        email: user.email,
        pic: user.pic,
      },
    };
  }

  async refreshToken(token: string) {
    try {
      const payload: { id: string; email: string } =
        this.jwtService.verify(token);
      const user = await this.userService.findById(payload.id);
      if (!user) {
        throw new UnauthorizedException('User not found');
      }
      const newPayload = { email: user.email, id: user._id };
      return {
        access_token: this.jwtService.sign(newPayload),
      };
    } catch {
      throw new UnauthorizedException('Invalid refresh token');
    }
  }
}
