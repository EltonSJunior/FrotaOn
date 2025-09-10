import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { TravelsModule } from './travels/travels.module';
import { ChecklistsModule } from './checklists/checklists.module';
import { ImagesModule } from './images/images.module';

@Module({
  imports: [
    AuthModule,
    UsersModule,
    TravelsModule,
    ChecklistsModule,
    ImagesModule,
  ],
})
export class AppModule {}
