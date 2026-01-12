import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber, IsString, Min } from 'class-validator';
import { FileUploadDto } from 'src/common/dto/file-upload.dto';

export class SendMessageDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  chatId: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  content: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  contentType: string;
}

export class SendFileDto extends FileUploadDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  chatId: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  contentType: string;
}

export class FetchMessageDto {
  @IsString()
  @IsNotEmpty()
  chatId: string;

  @IsNumber()
  @Min(1)
  page: number;
}

export class DeleteMessageDto {
  @IsString()
  @IsNotEmpty()
  messageId: string;
}
