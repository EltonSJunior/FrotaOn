import { Controller, Post, Body } from '@nestjs/common';
import { ImagesService } from './images.service';

@Controller('images')
export class ImagesController {
  constructor(private imagesService: ImagesService) {}

  @Post()
  async upload(@Body() body: { name: string; kind: string; base64: string }) {
    const imageId = await this.imagesService.saveImage(body);
    return { imageId };
  }
}