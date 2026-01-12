import {
  BadRequestException,
  Body,
  Controller,
  Get,
  HttpCode,
  NotFoundException,
  Post,
  Put,
  Query,
  Req,
  UploadedFile,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ApiBody, ApiConsumes, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { UpdateProfileDto } from 'src/common/dto/file-upload.dto';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import type { RequestWithUser } from '../../common/interfaces/request-with-user.interface';
import { profileUploadOptions } from '../../common/utils/file-upload.util';
import { ChangeNameDto } from './dto/change-name.dto';
import { ChangePasswordDto } from './dto/change-password.dto';
import { CreateUserDto } from './dto/create-user.dto';
import { UserService } from './user.service';

@ApiTags('User')
@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Post('register')
  async register(@Body() createUserDto: CreateUserDto) {
    return this.userService.create(createUserDto);
  }

  @UseGuards(JwtAuthGuard)
  @Get()
  async getAllUsers(
    @Query('search') search: string,
    @Req() req: RequestWithUser,
  ) {
    return this.userService.search(search || '', req.user.userId);
  }

  @ApiOkResponse({ description: 'User found successfully' })
  @UseGuards(JwtAuthGuard)
  @Post('searchUser')
  @HttpCode(200)
  async searchUser(@Body('name') name: string, @Req() req: RequestWithUser) {
    return this.userService.search(name || '', req.user.userId);
  }

  @ApiConsumes('multipart/form-data')
  @ApiBody({
    description: 'User profile picture',
    type: UpdateProfileDto,
  })
  @UseGuards(JwtAuthGuard)
  @Put('updateProfile')
  @UseInterceptors(FileInterceptor('file', profileUploadOptions))
  async updateProfile(
    @UploadedFile() file: Express.Multer.File,
    @Req() req: RequestWithUser,
  ) {
    let fileName: string | null = null;
    if (file) {
      const userId = req.user.userId;
      fileName = file.filename;
      return this.userService.updateProfile(userId, fileName);
    }
    throw new NotFoundException('File not found');
  }

  @UseGuards(JwtAuthGuard)
  @Put('changePassword')
  async changePassword(
    @Body() changePasswordDto: ChangePasswordDto,
    @Req() req: RequestWithUser,
  ) {
    if (changePasswordDto.password !== changePasswordDto.confirmPassword) {
      throw new BadRequestException(
        'Password and confirm password do not match',
      );
    }
    return this.userService.changePassword(
      req.user.userId,
      changePasswordDto.oldPassword,
      changePasswordDto.password,
    );
  }

  @UseGuards(JwtAuthGuard)
  @Put('changeName')
  async changeName(
    @Body() changeNameDto: ChangeNameDto,
    @Req() req: RequestWithUser,
  ) {
    return this.userService.changeName(req.user.userId, changeNameDto.name);
  }
}
