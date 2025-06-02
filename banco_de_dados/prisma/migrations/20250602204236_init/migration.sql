-- CreateTable
CREATE TABLE "sponsor" (
    "id_sponsor" SERIAL NOT NULL,
    "nameSponsor" TEXT NOT NULL,
    "descriptionSponsor" TEXT NOT NULL,
    "descriptionTitle" TEXT NOT NULL,
    "exclusiveUrl" TEXT NOT NULL,
    "site_web" TEXT NOT NULL,
    "facebook" TEXT,
    "instagram" TEXT,
    "linkedin" TEXT,
    "tiktok" TEXT,
    "kawai" TEXT,
    "whatsapp" TEXT,
    "x" TEXT,
    "lowSponsorLogo" TEXT NOT NULL DEFAULT '',
    "highSponsorLogo" TEXT NOT NULL,
    "urlSponsor" TEXT NOT NULL,

    CONSTRAINT "sponsor_pkey" PRIMARY KEY ("id_sponsor")
);

-- CreateTable
CREATE TABLE "planData" (
    "id_planData" SERIAL NOT NULL,
    "planName" TEXT NOT NULL,
    "planActive" BOOLEAN NOT NULL DEFAULT true,
    "productsPerStore" INTEGER NOT NULL,
    "storeQuantity" INTEGER NOT NULL,
    "communityQuantity" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "duration_months" INTEGER NOT NULL,

    CONSTRAINT "planData_pkey" PRIMARY KEY ("id_planData")
);

-- CreateTable
CREATE TABLE "sponsor_plan" (
    "id_sponsor_plan" SERIAL NOT NULL,
    "sponsor_id" INTEGER NOT NULL,
    "planData_id" INTEGER NOT NULL,
    "quantity_purchased" INTEGER NOT NULL DEFAULT 1,
    "purchased_date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "sponsor_plan_pkey" PRIMARY KEY ("id_sponsor_plan")
);

-- CreateTable
CREATE TABLE "owner" (
    "id_owner" SERIAL NOT NULL,
    "storeOwnerId" TEXT NOT NULL,
    "owner_name" TEXT NOT NULL,

    CONSTRAINT "owner_pkey" PRIMARY KEY ("id_owner")
);

-- CreateTable
CREATE TABLE "owner_sponsor_plan" (
    "id_owner_sponsor_plan" SERIAL NOT NULL,
    "owner_id" INTEGER NOT NULL,
    "sponsor_plan_id" INTEGER NOT NULL,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3) NOT NULL,
    "observation" TEXT,

    CONSTRAINT "owner_sponsor_plan_pkey" PRIMARY KEY ("id_owner_sponsor_plan")
);

-- CreateTable
CREATE TABLE "store" (
    "id_store" SERIAL NOT NULL,
    "owner_id" INTEGER NOT NULL,
    "storeId" TEXT NOT NULL,
    "storeCategory" TEXT NOT NULL,
    "storeName" TEXT NOT NULL,
    "shortDescription" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "affiliatedStore" BOOLEAN NOT NULL DEFAULT true,
    "productLinkStore" BOOLEAN NOT NULL DEFAULT true,
    "storeAffiliatedLink" TEXT,
    "storeImage" TEXT NOT NULL,
    "store_creation_date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "store_pkey" PRIMARY KEY ("id_store")
);

-- CreateTable
CREATE TABLE "users" (
    "id_user" SERIAL NOT NULL,
    "owner_id" INTEGER NOT NULL,
    "user_date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id_user")
);

-- CreateTable
CREATE TABLE "community" (
    "id_community" SERIAL NOT NULL,
    "placeId" INTEGER NOT NULL,
    "bairro" TEXT NOT NULL,
    "cep" TEXT NOT NULL,
    "cidade" TEXT NOT NULL,
    "condominio" TEXT,
    "endereco" TEXT NOT NULL,
    "estado" TEXT NOT NULL,
    "geoPoint" TEXT NOT NULL,
    "locale" TEXT NOT NULL,
    "tipoLocal" TEXT NOT NULL,
    "owner_id" INTEGER NOT NULL,
    "community_creation_date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "community_pkey" PRIMARY KEY ("id_community")
);

-- CreateTable
CREATE TABLE "owner_community" (
    "owner_id" INTEGER NOT NULL,
    "community_id" INTEGER NOT NULL,
    "registration_date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "owner_community_pkey" PRIMARY KEY ("owner_id","community_id")
);

-- CreateTable
CREATE TABLE "users_community" (
    "user_id" INTEGER NOT NULL,
    "community_id" INTEGER NOT NULL,

    CONSTRAINT "users_community_pkey" PRIMARY KEY ("user_id","community_id")
);

-- CreateTable
CREATE TABLE "capture_candidate" (
    "id_cap_candidate" SERIAL NOT NULL,
    "full_name" TEXT NOT NULL,
    "cpf" TEXT NOT NULL,
    "birth_date" TEXT NOT NULL,
    "candidate_age" INTEGER NOT NULL,
    "gender" CHAR(1) NOT NULL,
    "street" TEXT NOT NULL,
    "number" TEXT NOT NULL,
    "complement" TEXT,
    "state" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "family_income" DOUBLE PRECISION NOT NULL,
    "email" TEXT NOT NULL,
    "education_level" TEXT NOT NULL,
    "notification_method" TEXT NOT NULL,
    "postal_code" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "capture_candidate_pkey" PRIMARY KEY ("id_cap_candidate")
);

-- CreateTable
CREATE TABLE "sponsorship_slot" (
    "id_slot" SERIAL NOT NULL,
    "sponsor_plan_id" INTEGER NOT NULL,
    "slot_name" VARCHAR(50),
    "slot_slogan" VARCHAR(255),
    "slot_description" TEXT,
    "slot_city" VARCHAR(50),
    "slot_state" VARCHAR(50),
    "slot_max_income" DECIMAL(10,2),
    "slot_max_education_level" VARCHAR(50),
    "slot_min_age" INTEGER,
    "slot_quantity_available" INTEGER,

    CONSTRAINT "sponsorship_slot_pkey" PRIMARY KEY ("id_slot")
);

-- CreateTable
CREATE TABLE "sponsorship_selection" (
    "id_selection" SERIAL NOT NULL,
    "cap_candidate_id" INTEGER NOT NULL,
    "slot_id" INTEGER NOT NULL,
    "status_selection" TEXT NOT NULL,
    "selection_date" TIMESTAMP(3) NOT NULL,
    "expiration_date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "sponsorship_selection_pkey" PRIMARY KEY ("id_selection")
);

-- CreateIndex
CREATE UNIQUE INDEX "capture_candidate_cpf_key" ON "capture_candidate"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "capture_candidate_email_key" ON "capture_candidate"("email");

-- AddForeignKey
ALTER TABLE "sponsor_plan" ADD CONSTRAINT "sponsor_plan_sponsor_id_fkey" FOREIGN KEY ("sponsor_id") REFERENCES "sponsor"("id_sponsor") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sponsor_plan" ADD CONSTRAINT "sponsor_plan_planData_id_fkey" FOREIGN KEY ("planData_id") REFERENCES "planData"("id_planData") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "owner_sponsor_plan" ADD CONSTRAINT "owner_sponsor_plan_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "owner"("id_owner") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "owner_sponsor_plan" ADD CONSTRAINT "owner_sponsor_plan_sponsor_plan_id_fkey" FOREIGN KEY ("sponsor_plan_id") REFERENCES "sponsor_plan"("id_sponsor_plan") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store" ADD CONSTRAINT "store_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "owner"("id_owner") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "owner"("id_owner") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "owner_community" ADD CONSTRAINT "owner_community_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "owner"("id_owner") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "owner_community" ADD CONSTRAINT "owner_community_community_id_fkey" FOREIGN KEY ("community_id") REFERENCES "community"("id_community") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_community" ADD CONSTRAINT "users_community_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_community" ADD CONSTRAINT "users_community_community_id_fkey" FOREIGN KEY ("community_id") REFERENCES "community"("id_community") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sponsorship_slot" ADD CONSTRAINT "sponsorship_slot_sponsor_plan_id_fkey" FOREIGN KEY ("sponsor_plan_id") REFERENCES "sponsor_plan"("id_sponsor_plan") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sponsorship_selection" ADD CONSTRAINT "sponsorship_selection_cap_candidate_id_fkey" FOREIGN KEY ("cap_candidate_id") REFERENCES "capture_candidate"("id_cap_candidate") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sponsorship_selection" ADD CONSTRAINT "sponsorship_selection_slot_id_fkey" FOREIGN KEY ("slot_id") REFERENCES "sponsorship_slot"("id_slot") ON DELETE RESTRICT ON UPDATE CASCADE;
