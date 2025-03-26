-- CreateTable
CREATE TABLE `planData` (
    `plan_id_bd` INTEGER NOT NULL,
    `planName` VARCHAR(20) NOT NULL,
    `planActive` BOOLEAN NOT NULL,
    `productInStore` INTEGER NOT NULL,
    `storeQuantity` INTEGER NOT NULL,
    `communityQuantity` INTEGER NOT NULL,
    `price` DECIMAL(10, 2) NOT NULL,

    PRIMARY KEY (`plan_id_bd`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sponsor` (
    `sponsor_id_bd` INTEGER NOT NULL,
    `descriptionSponsor` VARCHAR(255) NULL,
    `descriptionTitle` VARCHAR(255) NULL,
    `expirationUrl` VARCHAR(255) NULL,
    `facebook` VARCHAR(255) NULL,
    `highSponsorLogo` VARCHAR(255) NULL,
    `instagram` VARCHAR(255) NULL,
    `kawai` VARCHAR(255) NULL,
    `linkedin` VARCHAR(255) NULL,
    `lowSponsorLogo` VARCHAR(255) NULL,
    `nameSponsor` VARCHAR(255) NOT NULL,
    `site_web` VARCHAR(255) NULL,
    `tiktok` VARCHAR(255) NULL,
    `urlSponsor` VARCHAR(255) NULL,
    `whatsapp` VARCHAR(255) NULL,
    `x` VARCHAR(255) NULL,

    PRIMARY KEY (`sponsor_id_bd`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `owner` (
    `owner_id_bd` INTEGER NOT NULL,
    `storeOwnerId` INTEGER NULL,
    `owner_name` VARCHAR(100) NOT NULL,

    UNIQUE INDEX `owner_storeOwnerId_key`(`storeOwnerId`),
    PRIMARY KEY (`owner_id_bd`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `store` (
    `store_id_bd` INTEGER NOT NULL,
    `storeId` VARCHAR(255) NULL,
    `storeCategory` VARCHAR(100) NULL,
    `storeName` VARCHAR(100) NOT NULL,
    `shortDescription` VARCHAR(255) NULL,
    `isActive` BOOLEAN NOT NULL,
    `affiliateStore` BOOLEAN NOT NULL,
    `productLikeStore` BOOLEAN NOT NULL,
    `storeAffiliateLink` VARCHAR(255) NULL,
    `data_criacao` DATE NULL,
    `owner_owner_id_bd` INTEGER NULL,

    PRIMARY KEY (`store_id_bd`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community` (
    `community_id_bd` INTEGER NOT NULL,
    `placeId` INTEGER NULL,
    `bairro` VARCHAR(100) NULL,
    `cep` VARCHAR(8) NULL,
    `cidade` VARCHAR(100) NOT NULL,
    `condominio` VARCHAR(100) NULL,
    `endereco` VARCHAR(255) NULL,
    `estado` VARCHAR(100) NOT NULL,
    `geoPoint` VARCHAR(255) NULL,
    `local` VARCHAR(255) NULL,
    `tipoLocal` VARCHAR(100) NULL,
    `owner_owner_id_bd` INTEGER NULL,

    UNIQUE INDEX `community_placeId_key`(`placeId`),
    PRIMARY KEY (`community_id_bd`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `usuario` (
    `user_id_bd` INTEGER NOT NULL,
    `owner_owner_id_bd` INTEGER NULL,

    PRIMARY KEY (`user_id_bd`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sponsor_owner_plan` (
    `sponsor_sponsor_id_bd` INTEGER NOT NULL,
    `planData_plan_id_bd` INTEGER NOT NULL,
    `data_inicio` DATETIME(0) NOT NULL,
    `data_fim` DATETIME(0) NULL,

    PRIMARY KEY (`sponsor_sponsor_id_bd`, `planData_plan_id_bd`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `owner_community` (
    `owner_owner_id_bd` INTEGER NOT NULL,
    `community_community_id_bd` INTEGER NOT NULL,

    PRIMARY KEY (`owner_owner_id_bd`, `community_community_id_bd`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `usuario_community` (
    `usuario_user_id_bd` INTEGER NOT NULL,
    `community_community_id_bd` INTEGER NOT NULL,

    PRIMARY KEY (`usuario_user_id_bd`, `community_community_id_bd`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `store` ADD CONSTRAINT `store_owner_owner_id_bd_fkey` FOREIGN KEY (`owner_owner_id_bd`) REFERENCES `owner`(`owner_id_bd`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `community` ADD CONSTRAINT `community_owner_owner_id_bd_fkey` FOREIGN KEY (`owner_owner_id_bd`) REFERENCES `owner`(`owner_id_bd`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `usuario` ADD CONSTRAINT `usuario_owner_owner_id_bd_fkey` FOREIGN KEY (`owner_owner_id_bd`) REFERENCES `owner`(`owner_id_bd`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `sponsor_owner_plan` ADD CONSTRAINT `sponsor_owner_plan_sponsor_sponsor_id_bd_fkey` FOREIGN KEY (`sponsor_sponsor_id_bd`) REFERENCES `sponsor`(`sponsor_id_bd`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `sponsor_owner_plan` ADD CONSTRAINT `sponsor_owner_plan_planData_plan_id_bd_fkey` FOREIGN KEY (`planData_plan_id_bd`) REFERENCES `planData`(`plan_id_bd`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `owner_community` ADD CONSTRAINT `owner_community_owner_owner_id_bd_fkey` FOREIGN KEY (`owner_owner_id_bd`) REFERENCES `owner`(`owner_id_bd`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `owner_community` ADD CONSTRAINT `owner_community_community_community_id_bd_fkey` FOREIGN KEY (`community_community_id_bd`) REFERENCES `community`(`community_id_bd`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `usuario_community` ADD CONSTRAINT `usuario_community_usuario_user_id_bd_fkey` FOREIGN KEY (`usuario_user_id_bd`) REFERENCES `usuario`(`user_id_bd`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `usuario_community` ADD CONSTRAINT `usuario_community_community_community_id_bd_fkey` FOREIGN KEY (`community_community_id_bd`) REFERENCES `community`(`community_id_bd`) ON DELETE RESTRICT ON UPDATE CASCADE;
