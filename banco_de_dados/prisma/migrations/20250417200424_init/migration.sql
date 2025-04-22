-- CreateTable
CREATE TABLE `sponsor` (
    `id_sponsor` INTEGER NOT NULL AUTO_INCREMENT,
    `nameSponsor` VARCHAR(191) NOT NULL,
    `descriptionSponsor` VARCHAR(191) NOT NULL,
    `descriptionTitle` VARCHAR(191) NOT NULL,
    `exclusiveUrl` VARCHAR(191) NOT NULL,
    `site_web` VARCHAR(191) NOT NULL,
    `facebook` VARCHAR(191) NULL,
    `instagram` VARCHAR(191) NULL,
    `linkedin` VARCHAR(191) NULL,
    `tiktok` VARCHAR(191) NULL,
    `kawai` VARCHAR(191) NULL,
    `whatsapp` VARCHAR(191) NULL,
    `x` VARCHAR(191) NULL,
    `lowSponsorLogo` VARCHAR(191) NOT NULL DEFAULT '',
    `highSponsorLogo` VARCHAR(191) NOT NULL,
    `urlSponsor` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id_sponsor`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `planData` (
    `id_planData` INTEGER NOT NULL AUTO_INCREMENT,
    `planName` VARCHAR(191) NOT NULL,
    `planActive` BOOLEAN NOT NULL DEFAULT true,
    `productsPerStore` INTEGER NOT NULL,
    `storeQuantity` INTEGER NOT NULL,
    `communityQuantity` INTEGER NOT NULL,
    `price` DOUBLE NOT NULL,
    `duration_months` INTEGER NOT NULL,

    PRIMARY KEY (`id_planData`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sponsor_plan` (
    `id_sponsor_plan` INTEGER NOT NULL AUTO_INCREMENT,
    `sponsor_id` INTEGER NOT NULL,
    `planData_id` INTEGER NOT NULL,
    `quantity_purchased` INTEGER NOT NULL DEFAULT 1,
    `purchased_date` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id_sponsor_plan`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `owner` (
    `id_owner` INTEGER NOT NULL AUTO_INCREMENT,
    `storeOwnerId` VARCHAR(191) NOT NULL,
    `owner_name` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id_owner`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `owner_sponsor_plan` (
    `id_owner_sponsor_plan` INTEGER NOT NULL AUTO_INCREMENT,
    `owner_id` INTEGER NOT NULL,
    `sponsor_plan_id` INTEGER NOT NULL,
    `start_date` DATETIME(3) NOT NULL,
    `end_date` DATETIME(3) NOT NULL,
    `observation` VARCHAR(191) NULL,

    PRIMARY KEY (`id_owner_sponsor_plan`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `store` (
    `id_store` INTEGER NOT NULL AUTO_INCREMENT,
    `owner_id` INTEGER NOT NULL,
    `storeId` VARCHAR(191) NOT NULL,
    `storeCategory` VARCHAR(191) NOT NULL,
    `storeName` VARCHAR(191) NOT NULL,
    `shortDescription` VARCHAR(191) NOT NULL,
    `isActive` BOOLEAN NOT NULL DEFAULT true,
    `affiliatedStore` BOOLEAN NOT NULL DEFAULT true,
    `productLinkStore` BOOLEAN NOT NULL DEFAULT true,
    `storeAffiliatedLink` VARCHAR(191) NULL,
    `storeImage` VARCHAR(191) NOT NULL,
    `store_creation_date` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id_store`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `id_user` INTEGER NOT NULL AUTO_INCREMENT,
    `owner_id` INTEGER NOT NULL,
    `user_date` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id_user`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community` (
    `id_community` INTEGER NOT NULL AUTO_INCREMENT,
    `placeId` INTEGER NOT NULL,
    `bairro` VARCHAR(191) NOT NULL,
    `cep` VARCHAR(191) NOT NULL,
    `cidade` VARCHAR(191) NOT NULL,
    `condominio` VARCHAR(191) NULL,
    `endereco` VARCHAR(191) NOT NULL,
    `estado` VARCHAR(191) NOT NULL,
    `geoPoint` VARCHAR(191) NOT NULL,
    `locale` VARCHAR(191) NOT NULL,
    `tipoLocal` VARCHAR(191) NOT NULL,
    `owner_id` INTEGER NOT NULL,
    `community_creation_date` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id_community`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `owner_community` (
    `owner_id` INTEGER NOT NULL,
    `community_id` INTEGER NOT NULL,
    `registration_date` DATETIME(3) NOT NULL,

    PRIMARY KEY (`owner_id`, `community_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users_community` (
    `user_id` INTEGER NOT NULL,
    `community_id` INTEGER NOT NULL,

    PRIMARY KEY (`user_id`, `community_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `capture_candidate` (
    `id_cap_candidate` INTEGER NOT NULL AUTO_INCREMENT,
    `full_name` VARCHAR(191) NOT NULL,
    `cpf` VARCHAR(191) NOT NULL,
    `birth_date` VARCHAR(191) NOT NULL,
    `candidate_age` INTEGER NOT NULL,
    `gender` CHAR(1) NOT NULL,
    `street` VARCHAR(191) NOT NULL,
    `number` VARCHAR(191) NOT NULL,
    `complement` VARCHAR(191) NULL,
    `state` VARCHAR(191) NOT NULL,
    `city` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NOT NULL,
    `family_income` DOUBLE NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `education_level` VARCHAR(191) NOT NULL,
    `notification_method` VARCHAR(191) NOT NULL,
    `postal_code` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL,

    UNIQUE INDEX `capture_candidate_cpf_key`(`cpf`),
    UNIQUE INDEX `capture_candidate_email_key`(`email`),
    PRIMARY KEY (`id_cap_candidate`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sponsorship_slot` (
    `id_slot` INTEGER NOT NULL AUTO_INCREMENT,
    `sponsor_plan_id` INTEGER NOT NULL,
    `slot_state` VARCHAR(191) NOT NULL,
    `slot_city` VARCHAR(191) NOT NULL,
    `slot_max_income` DOUBLE NOT NULL,
    `slot_min_education_level` VARCHAR(191) NOT NULL,
    `slot_quantity_available` INTEGER NOT NULL,
    `slot_min_age` INTEGER NOT NULL,

    PRIMARY KEY (`id_slot`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sponsorship_selection` (
    `id_selection` INTEGER NOT NULL AUTO_INCREMENT,
    `cap_candidate_id` INTEGER NOT NULL,
    `slot_id` INTEGER NOT NULL,
    `status_selection` VARCHAR(191) NOT NULL,
    `selection_date` DATETIME(3) NOT NULL,
    `expiration_date` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id_selection`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `sponsor_plan` ADD CONSTRAINT `sponsor_plan_sponsor_id_fkey` FOREIGN KEY (`sponsor_id`) REFERENCES `sponsor`(`id_sponsor`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `sponsor_plan` ADD CONSTRAINT `sponsor_plan_planData_id_fkey` FOREIGN KEY (`planData_id`) REFERENCES `planData`(`id_planData`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `owner_sponsor_plan` ADD CONSTRAINT `owner_sponsor_plan_owner_id_fkey` FOREIGN KEY (`owner_id`) REFERENCES `owner`(`id_owner`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `owner_sponsor_plan` ADD CONSTRAINT `owner_sponsor_plan_sponsor_plan_id_fkey` FOREIGN KEY (`sponsor_plan_id`) REFERENCES `sponsor_plan`(`id_sponsor_plan`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `store` ADD CONSTRAINT `store_owner_id_fkey` FOREIGN KEY (`owner_id`) REFERENCES `owner`(`id_owner`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `users` ADD CONSTRAINT `users_owner_id_fkey` FOREIGN KEY (`owner_id`) REFERENCES `owner`(`id_owner`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `owner_community` ADD CONSTRAINT `owner_community_owner_id_fkey` FOREIGN KEY (`owner_id`) REFERENCES `owner`(`id_owner`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `owner_community` ADD CONSTRAINT `owner_community_community_id_fkey` FOREIGN KEY (`community_id`) REFERENCES `community`(`id_community`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `users_community` ADD CONSTRAINT `users_community_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id_user`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `users_community` ADD CONSTRAINT `users_community_community_id_fkey` FOREIGN KEY (`community_id`) REFERENCES `community`(`id_community`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `sponsorship_slot` ADD CONSTRAINT `sponsorship_slot_sponsor_plan_id_fkey` FOREIGN KEY (`sponsor_plan_id`) REFERENCES `sponsor_plan`(`id_sponsor_plan`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `sponsorship_selection` ADD CONSTRAINT `sponsorship_selection_cap_candidate_id_fkey` FOREIGN KEY (`cap_candidate_id`) REFERENCES `capture_candidate`(`id_cap_candidate`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `sponsorship_selection` ADD CONSTRAINT `sponsorship_selection_slot_id_fkey` FOREIGN KEY (`slot_id`) REFERENCES `sponsorship_slot`(`id_slot`) ON DELETE RESTRICT ON UPDATE CASCADE;
