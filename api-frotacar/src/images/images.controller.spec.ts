import { Test, TestingModule } from '@nestjs/testing';
import { ImagesController } from './images.controller';
import { ImagesService } from './images.service';

describe('ImagesController', () => {
  let controller: ImagesController;
  let service: ImagesService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ImagesController],
      providers: [
        {
          provide: ImagesService,
          useValue: { saveImage: jest.fn().mockResolvedValue(1) },
        },
      ],
    }).compile();

    controller = module.get<ImagesController>(ImagesController);
    service = module.get<ImagesService>(ImagesService);
  });

  it('should upload image and return imageId', async () => {
    const result = await controller.upload({ name: 'img', kind: 'FRENTE', base64: 'aGVsbG8=' });
    expect(result).toEqual({ imageId: 1 });
  });
});