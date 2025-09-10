import { ImagesService } from './images.service';

describe('ImagesService', () => {
  let service: ImagesService;
  let prisma: any;

  beforeEach(() => {
    prisma = { image: { create: jest.fn().mockResolvedValue({ id: 1 }) } };
    service = new ImagesService(prisma);
  });

  it('should save image and return id', async () => {
    const id = await service.saveImage({ name: 'img', kind: 'FRENTE', base64: 'aGVsbG8=' });
    expect(id).toBe(1);
    expect(prisma.image.create).toHaveBeenCalled();
  });
});