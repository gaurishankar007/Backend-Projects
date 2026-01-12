import {
  IsNotEmpty,
  IsString,
  Matches,
  MaxLength,
  MinLength,
} from 'class-validator';

export class ChangePasswordDto {
  @IsString()
  @IsNotEmpty()
  oldPassword: string;

  @IsString()
  @IsNotEmpty()
  @MinLength(5)
  @MaxLength(15)
  @Matches(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{5,15}$/, {
    message:
      'Password must have 5 to 15 characters and at least 1 uppercase, lowercase, and numeric digit',
  })
  password: string;

  @IsString()
  @IsNotEmpty()
  confirmPassword: string;
}
