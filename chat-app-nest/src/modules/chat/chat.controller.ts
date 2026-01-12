import {
  Body,
  Controller,
  Delete,
  Get,
  Post,
  Put,
  Req,
  UseGuards,
} from '@nestjs/common';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import type { RequestWithUser } from '../../common/interfaces/request-with-user.interface';
import { ChatService } from './chat.service';
import {
  AddMemberDto,
  CreateChatDto,
  CreateGroupDto,
  DeleteChatDto,
  RemoveMemberDto,
} from './dto/chat.dto';

@UseGuards(JwtAuthGuard)
@Controller('chat')
export class ChatController {
  constructor(private readonly chatService: ChatService) {}

  @Post('create')
  async accessChat(
    @Body() createChatDto: CreateChatDto,
    @Req() req: RequestWithUser,
  ) {
    return this.chatService.accessChat(createChatDto.userId, req.user.userId);
  }

  @Post('createGroup')
  async createGroupChat(
    @Body() createGroupDto: CreateGroupDto,
    @Req() req: RequestWithUser,
  ) {
    return this.chatService.createGroupChat(
      createGroupDto.name || 'New Group Chat',
      createGroupDto.userIds,
      req.user.userId,
    );
  }

  @Get('fetch')
  async fetchChats(@Req() req: RequestWithUser) {
    // Note: Original express had page validation, but fetchChats base service doesn't use it yet.
    // Keeping it simple for now to match current service implementation.
    return this.chatService.fetchChats(req.user.userId);
  }

  @Put('addMember')
  async addMember(@Body() addMemberDto: AddMemberDto) {
    return this.chatService.addMembers(
      addMemberDto.chatId,
      addMemberDto.userIds,
    );
  }

  @Delete('removeMember')
  async removeMember(@Body() removeMemberDto: RemoveMemberDto) {
    return this.chatService.removeMember(
      removeMemberDto.chatId,
      removeMemberDto.userId,
    );
  }

  @Delete('deleteGroup')
  async deleteGroupChat(
    @Body() deleteChatDto: DeleteChatDto,
    @Req() req: RequestWithUser,
  ) {
    return this.chatService.deleteGroupChat(
      deleteChatDto.chatId,
      req.user.userId,
    );
  }
}
