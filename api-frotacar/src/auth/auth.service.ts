import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { PrismaService } from 'prisma/prisma.service';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService,
  ) {}

  async validateUser(username: string, password: string) {
    const user = await this.prisma.user.findFirst({ where: { email: username } });
    if (!user || !(await bcrypt.compare(password, user.password))) {
      throw new UnauthorizedException('Invalid credentials');
    }
    return user;
  }

  async login(user: any) {
    const payload = {
      sub: user.id,
      isAdmin: user.isAdmin,
      isManager: user.isManager,
      isFleetApprover: user.isFleetApprover,
      isGuard: user.isGuard,
      hasDefensiveCourse: user.hasDefensiveCourse,
    };
    return {
      access_token: this.jwtService.sign(payload),
    };
  }
}