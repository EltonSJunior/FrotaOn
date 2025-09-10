/*
  Warnings:

  - Added the required column `bytes` to the `Image` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Image` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."Image" ADD COLUMN     "bytes" BYTEA NOT NULL,
ADD COLUMN     "name" TEXT NOT NULL;
