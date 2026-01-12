import {
  ArrayMinSize,
  IsArray,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  Min,
} from 'class-validator';

export class CreateChatDto {
  @IsString()
  @IsNotEmpty()
  userId: string;
}

export class CreateGroupDto {
  @IsString()
  @IsOptional()
  name?: string;

  @IsArray()
  @IsString({ each: true })
  @ArrayMinSize(2)
  userIds: string[];
}

export class AddMemberDto {
  @IsString()
  @IsNotEmpty()
  chatId: string;

  @IsArray()
  @IsString({ each: true })
  @ArrayMinSize(1)
  userIds: string[];
}

export class RemoveMemberDto {
  @IsString()
  @IsNotEmpty()
  chatId: string;

  @IsString()
  @IsNotEmpty()
  userId: string;
}

export class FetchChatDto {
  @IsNumber()
  @Min(1)
  page: number;
}

export class DeleteChatDto {
  @IsString()
  @IsNotEmpty()
  chatId: string;
}
