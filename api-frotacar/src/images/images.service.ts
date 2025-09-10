import { Injectable, BadRequestException } from '@nestjs/common';
import { PrismaService } from 'prisma/prisma.service';

const VALID_KINDS = ['FRENTE', 'LAT_ESQ', 'LAT_DIR', 'TRASEIRA', 'PAINEL', 'EXTRA'];

@Injectable()
export class ImagesService {
  constructor(private prisma: PrismaService) {}

  async saveImage(data: { name: string; kind: string; base64: string }) {
    if (!VALID_KINDS.includes(data.kind)) {
      throw new BadRequestException('Invalid image kind');
    }
    const buffer = Buffer.from(data.base64, 'base64');
    const image = await this.prisma.image.create({
      data: {
        name: data.name,
        kind: data.kind as any, // Cast para o tipo enum
        bytes: buffer,
      },
    });
    return image.id;
  }
}