import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { NestExpressApplication } from '@nestjs/platform-express';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { join } from 'path';
import { AppModule } from './app.module';
import { AllExceptionsFilter } from './common/filters/http-exception.filter';
import { TransformInterceptor } from './common/interceptors/transform.interceptor';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);

  // This adds 'api' to EVERY route in the app automatically
  app.setGlobalPrefix('api');

  app.useStaticAssets(join(__dirname, '..', 'public'), {
    prefix: '/public/',
  });

  // Register Global Pipe
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true, // strip properties not in DTO
      transform: true, // automatically transform payloads to DTO instances
    }),
  );

  // Register Global Filter
  app.useGlobalFilters(new AllExceptionsFilter());

  // Register Global Interceptor
  app.useGlobalInterceptors(new TransformInterceptor());

  // Swagger Configuration
  const config = new DocumentBuilder()
    .setTitle('Chat App API')
    .setDescription('The Chat App API description')
    .setVersion('1.0')
    .addBearerAuth()
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);

  app.enableCors();

  await app.listen(process.env.PORT ?? 3000);
}

void bootstrap();
