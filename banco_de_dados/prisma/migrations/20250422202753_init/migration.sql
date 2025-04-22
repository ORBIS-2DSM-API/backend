/*
  Warnings:

  - You are about to drop the column `slot_min_education_level` on the `sponsorship_slot` table. All the data in the column will be lost.
  - You are about to alter the column `slot_state` on the `sponsorship_slot` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `VarChar(50)`.
  - You are about to alter the column `slot_city` on the `sponsorship_slot` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `VarChar(50)`.

*/
-- AlterTable
ALTER TABLE `sponsorship_slot` DROP COLUMN `slot_min_education_level`,
    ADD COLUMN `slot_description` TEXT NULL,
    ADD COLUMN `slot_max_education_level` VARCHAR(20) NULL,
    ADD COLUMN `slot_name` VARCHAR(50) NULL,
    ADD COLUMN `slot_slogan` VARCHAR(255) NULL,
    MODIFY `slot_state` VARCHAR(50) NULL,
    MODIFY `slot_city` VARCHAR(50) NULL,
    MODIFY `slot_max_income` DECIMAL(10, 2) NULL,
    MODIFY `slot_quantity_available` INTEGER NULL,
    MODIFY `slot_min_age` INTEGER NULL;
