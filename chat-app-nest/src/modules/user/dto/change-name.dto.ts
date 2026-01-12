import { IsNotEmpty, IsString, MinLength } from 'class-validator';

export class ChangeNameDto {
  @IsString()
  @IsNotEmpty()
  @MinLength(3)
  name: string;
}
