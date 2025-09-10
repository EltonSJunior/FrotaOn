-- CreateEnum
CREATE TYPE "public"."ChecklistKind" AS ENUM ('SAIDA', 'CHEGADA');

-- CreateEnum
CREATE TYPE "public"."ImageKind" AS ENUM ('FRENTE', 'LAT_ESQ', 'LAT_DIR', 'TRASEIRA', 'PAINEL', 'EXTRA');

-- CreateTable
CREATE TABLE "public"."User" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Branch" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Branch_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Vehicle" (
    "id" SERIAL NOT NULL,
    "plate" TEXT NOT NULL,
    "defaultBranchId" INTEGER,

    CONSTRAINT "Vehicle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."City" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "City_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Route" (
    "id" SERIAL NOT NULL,
    "branchId" INTEGER NOT NULL,
    "originId" INTEGER,
    "destinationId" INTEGER,

    CONSTRAINT "Route_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Sector" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Sector_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TravelMotive" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "TravelMotive_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."VehicleType" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "VehicleType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."CancelMotive" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "CancelMotive_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TravelRequest" (
    "id" SERIAL NOT NULL,
    "sectorId" INTEGER NOT NULL,
    "routeId" INTEGER NOT NULL,
    "branchId" INTEGER NOT NULL,
    "motiveId" INTEGER NOT NULL,
    "vehicleTypeId" INTEGER NOT NULL,
    "cancelMotiveId" INTEGER,

    CONSTRAINT "TravelRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Checklist" (
    "id" SERIAL NOT NULL,
    "kind" "public"."ChecklistKind" NOT NULL,
    "createdById" INTEGER NOT NULL,

    CONSTRAINT "Checklist_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Image" (
    "id" SERIAL NOT NULL,
    "kind" "public"."ImageKind" NOT NULL,

    CONSTRAINT "Image_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ChecklistImage" (
    "id" SERIAL NOT NULL,
    "imageId" INTEGER NOT NULL,

    CONSTRAINT "ChecklistImage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TravelLog" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "TravelLog_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "public"."User"("email");

-- AddForeignKey
ALTER TABLE "public"."Vehicle" ADD CONSTRAINT "Vehicle_defaultBranchId_fkey" FOREIGN KEY ("defaultBranchId") REFERENCES "public"."Branch"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Route" ADD CONSTRAINT "Route_branchId_fkey" FOREIGN KEY ("branchId") REFERENCES "public"."Branch"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Route" ADD CONSTRAINT "Route_originId_fkey" FOREIGN KEY ("originId") REFERENCES "public"."City"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Route" ADD CONSTRAINT "Route_destinationId_fkey" FOREIGN KEY ("destinationId") REFERENCES "public"."City"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TravelRequest" ADD CONSTRAINT "TravelRequest_sectorId_fkey" FOREIGN KEY ("sectorId") REFERENCES "public"."Sector"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TravelRequest" ADD CONSTRAINT "TravelRequest_routeId_fkey" FOREIGN KEY ("routeId") REFERENCES "public"."Route"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TravelRequest" ADD CONSTRAINT "TravelRequest_branchId_fkey" FOREIGN KEY ("branchId") REFERENCES "public"."Branch"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TravelRequest" ADD CONSTRAINT "TravelRequest_motiveId_fkey" FOREIGN KEY ("motiveId") REFERENCES "public"."TravelMotive"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TravelRequest" ADD CONSTRAINT "TravelRequest_vehicleTypeId_fkey" FOREIGN KEY ("vehicleTypeId") REFERENCES "public"."VehicleType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TravelRequest" ADD CONSTRAINT "TravelRequest_cancelMotiveId_fkey" FOREIGN KEY ("cancelMotiveId") REFERENCES "public"."CancelMotive"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Checklist" ADD CONSTRAINT "Checklist_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ChecklistImage" ADD CONSTRAINT "ChecklistImage_imageId_fkey" FOREIGN KEY ("imageId") REFERENCES "public"."Image"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TravelLog" ADD CONSTRAINT "TravelLog_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
