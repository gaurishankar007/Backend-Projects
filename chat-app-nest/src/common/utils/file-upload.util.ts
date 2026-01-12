import { BadRequestException } from '@nestjs/common';
import { Request } from 'express';
import { diskStorage } from 'multer';
import { extname } from 'path';

export const storageConfig = (folder: string) =>
  diskStorage({
    destination: `./public/${folder}`,
    filename: (req, file, cb) => {
      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
      cb(null, `${uniqueSuffix}${extname(file.originalname)}`);
    },
  });

export const fileFilterConfig = (
  allowedMimeTypes: string[],
  errorMsg: string,
) => {
  return (
    req: Request,
    file: Express.Multer.File,
    cb: (error: Error | null, acceptFile: boolean) => void,
  ) => {
    if (allowedMimeTypes.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new BadRequestException(errorMsg), false);
    }
  };
};

export const multerOptions = (
  folder: string,
  allowedMimeTypes: string[],
  maxSize: number,
  errorMsg: string,
) => ({
  storage: storageConfig(folder),
  fileFilter: fileFilterConfig(allowedMimeTypes, errorMsg),
  limits: {
    fileSize: maxSize,
  },
});

export const imageUploadOptions = multerOptions(
  'images',
  ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'],
  50 * 1024 * 1024,
  'Unsupported image',
);

export const audioUploadOptions = multerOptions(
  'audios',
  [
    'audio/mp3',
    'audio/mp4',
    'audio/m4A',
    'audio/mpeg',
    'audio/wav',
    'audio/ogg',
    'audio/x-m4a',
  ],
  25 * 1024 * 1024,
  'Unsupported audio',
);

export const videoUploadOptions = multerOptions(
  'videos',
  ['video/mp4', 'video/mkv'],
  100 * 1024 * 1024,
  'Unsupported video',
);

export const profileUploadOptions = multerOptions(
  'profiles',
  ['image/jpg', 'image/jpeg', 'image/png'],
  10 * 1024 * 1024,
  'Unsupported image',
);
