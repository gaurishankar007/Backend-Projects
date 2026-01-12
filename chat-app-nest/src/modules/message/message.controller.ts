import {
  BadRequestException,
  Body,
  Controller,
  Delete,
  Post,
  Req,
  UploadedFile,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ApiBody, ApiConsumes, ApiTags } from '@nestjs/swagger';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import type { RequestWithUser } from '../../common/interfaces/request-with-user.interface';
import {
  audioUploadOptions,
  imageUploadOptions,
  videoUploadOptions,
} from '../../common/utils/file-upload.util';
import {
  DeleteMessageDto,
  FetchMessageDto,
  SendFileDto,
  SendMessageDto,
} from './dto/message.dto';
import { MessageService } from './message.service';

@ApiTags('Message')
@UseGuards(JwtAuthGuard)
@Controller('message')
export class MessageController {
  constructor(private readonly messageService: MessageService) {}

  @Post('text')
  async text(
    @Body() sendMessageDto: SendMessageDto,
    @Req() req: RequestWithUser,
  ) {
    return this.messageService.sendMessage(
      req.user.userId,
      sendMessageDto.content,
      sendMessageDto.chatId,
      sendMessageDto.contentType,
    );
  }

  @ApiConsumes('multipart/form-data')
  @ApiBody({ type: SendFileDto })
  @Post('image')
  @UseInterceptors(FileInterceptor('file', imageUploadOptions))
  async image(
    @Req() req: RequestWithUser,
    @Body() sendFileDto: SendFileDto,
    @UploadedFile() file: Express.Multer.File,
  ) {
    return this.messageService.sendMessage(
      req.user.userId,
      file.filename,
      sendFileDto.chatId,
      sendFileDto.contentType,
    );
  }

  @ApiConsumes('multipart/form-data')
  @ApiBody({ type: SendFileDto })
  @Post('audio')
  @UseInterceptors(FileInterceptor('file', audioUploadOptions))
  async audio(
    @Req() req: RequestWithUser,
    @Body() sendFileDto: SendFileDto,
    @UploadedFile() file: Express.Multer.File,
  ) {
    return this.messageService.sendMessage(
      req.user.userId,
      file.filename,
      sendFileDto.chatId,
      sendFileDto.contentType,
    );
  }

  @ApiConsumes('multipart/form-data')
  @ApiBody({ type: SendFileDto })
  @Post('video')
  @UseInterceptors(FileInterceptor('file', videoUploadOptions))
  async video(
    @Req() req: RequestWithUser,
    @Body() sendFileDto: SendFileDto,
    @UploadedFile() file: Express.Multer.File,
  ) {
    return this.messageService.sendMessage(
      req.user.userId,
      file.filename,
      sendFileDto.chatId,
      sendFileDto.contentType,
    );
  }

  @Post('fetch')
  async fetch(@Body() fetchMessageDto: FetchMessageDto) {
    return this.messageService.fetch(
      fetchMessageDto.chatId,
      fetchMessageDto.page,
    );
  }

  @Delete('delete')
  async deleteMessage(
    @Body() deleteMessageDto: DeleteMessageDto,
    @Req() req: RequestWithUser,
  ) {
    try {
      await this.messageService.deleteMessage(
        deleteMessageDto.messageId,
        req.user.userId,
      );
      return { message: 'Message deleted' };
    } catch (err: any) {
      const errorMessage = (err as Error).message;
      throw new BadRequestException(errorMessage);
    }
  }
}
