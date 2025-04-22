import { PrismaClient } from '@prisma/client';
import fs from 'fs';
import path from 'path';

const prisma = new PrismaClient();

async function main() {
  // Carrega o arquivo JSON
  const rawData = fs.readFileSync(path.join(__dirname, './assets/data.json'), 'utf-8');
  const data = JSON.parse(rawData);

  // 1. Popula a tabela sponsor
  console.log('Populando sponsors...');
  for (const sponsor of data.sponsor) {
    await prisma.sponsor.create({
      data: {
        id_sponsor: sponsor.id_sponsor,
        nameSponsor: sponsor.nameSponsor,
        descriptionSponsor: sponsor.descriptionSponsor,
        descriptionTitle: sponsor.descriptionTitle,
        exclusiveUrl: sponsor.exclusiveUrl,
        site_web: sponsor.site_web,
        facebook: sponsor.facebook || null,
        instagram: sponsor.instagram || null,
        linkedin: sponsor.linkedin || null,
        tiktok: sponsor.tiktok || null,
        kawai: sponsor.kawai || null,
        whatsapp: sponsor.whatsapp || null,
        x: sponsor.x || null,
        lowSponsorLogo: sponsor.lowSponsorLogo || '',
        highSponsorLogo: sponsor.highSponsorLogo,
        urlSponsor: sponsor.urlSponsor,
      },
    });
  }

  // 2. Popula a tabela planData
  console.log('Populando planos...');
  for (const plan of data.planData) {
    await prisma.planData.create({
      data: {
        id_planData: plan.id_planData,
        planName: plan.planName,
        planActive: plan.planActive,
        productsPerStore: plan.productsPerStore,
        storeQuantity: plan.storeQuantity,
        communityQuantity: plan.communityQuantity,
        price: plan.price,
        duration_months: plan.duration_months,
      },
    });
  }

  // 3. Popula a tabela sponsor_plan
  console.log('Populando sponsor plans...');
  for (const sponsorPlan of data.sponsor_plan) {
    await prisma.sponsor_plan.create({
      data: {
        id_sponsor_plan: sponsorPlan.id_sponsor_plan,
        sponsor_id: sponsorPlan.sponsor_id,
        planData_id: sponsorPlan.planData_id,
        quantity_purchased: sponsorPlan.quantity_purchased,
        purchased_date: new Date(sponsorPlan.purchased_date),
      },
    });
  }

  // 4. Popula a tabela owner
  console.log('Populando owners...');
  for (const owner of data.owner) {
    await prisma.owner.create({
      data: {
        id_owner: owner.id_owner,
        storeOwnerId: owner.storeOwnerId,
        owner_name: owner.owner_name,
      },
    });
  }

  // 5. Popula a tabela owner_sponsor_plan
  console.log('Populando owner sponsor plans...');
  for (const ownerSponsorPlan of data.owner_sponsor_plan) {
    await prisma.owner_sponsor_plan.create({
      data: {
        id_owner_sponsor_plan: ownerSponsorPlan.id_owner_sponsor_plan,
        owner_id: ownerSponsorPlan.owner_id,
        sponsor_plan_id: ownerSponsorPlan.sponsor_plan_id,
        start_date: new Date(ownerSponsorPlan.start_date),
        end_date: new Date(ownerSponsorPlan.end_date),
        observation: ownerSponsorPlan.observation || null,
      },
    });
  }

  // 6. Popula a tabela store
  console.log('Populando stores...');
  for (const store of data.store) {
    await prisma.store.create({
      data: {
        id_store: store.id_store,
        owner_id: store.owner_id,
        storeId: store.storeId,
        storeCategory: store.storeCategory,
        storeName: store.storeName,
        shortDescription: store.shortDescription,
        isActive: store.isActive,
        affiliatedStore: store.affiliatedStore,
        productLinkStore: store.productLinkStore,
        storeAffiliatedLink: store.storeAffiliatedLink || null,
        storeImage: store.storeImage,
        store_creation_date: new Date(store.store_creation_date),
      },
    });
  }

  // 7. Popula a tabela users
  console.log('Populando users...');
  for (const user of data.users) {
    await prisma.users.create({
      data: {
        id_user: user.id_user,
        owner_id: user.owner_id,
        user_date: new Date(user.user_date),
      },
    });
  }

  // 8. Popula a tabela community
  console.log('Populando communities...');
  for (const community of data.community) {
    await prisma.community.create({
      data: {
        id_community: community.id_community,
        placeId: community.placeId,
        bairro: community.bairro,
        cep: community.cep,
        cidade: community.cidade,
        condominio: community.condominio || null,
        endereco: community.endereco,
        estado: community.estado,
        geoPoint: community.geoPoint,
        locale: community.locale,
        tipoLocal: community.tipoLocal,
        owner_id: community.owner_id,
        community_creation_date: new Date(community.community_creation_date),
      },
    });
  }

  // 9. Popula a tabela owner_community
  console.log('Populando owner communities...');
  for (const ownerCommunity of data.owner_community) {
    await prisma.owner_community.create({
      data: {
        owner_id: ownerCommunity.owner_id,
        community_id: ownerCommunity.community_id,
        registration_date: new Date(ownerCommunity.registration_date),
      },
    });
  }

  // 10. Popula a tabela users_community
  console.log('Populando users communities...');
  for (const userCommunity of data.users_community) {
    await prisma.users_community.create({
      data: {
        user_id: userCommunity.user_id,
        community_id: userCommunity.community_id,
      },
    });
  }

  // 11. Popula a tabela capture_candidate
  console.log('Populando capture candidates...');
  for (const candidate of data.capture_candidate) {
    await prisma.capture_candidate.create({
      data: {
        id_cap_candidate: candidate.id_cap_candidate,
        full_name: candidate.full_name,
        cpf: candidate.cpf,
        birth_date: candidate.birth_date,
        candidate_age: candidate.candidate_age,
        gender: candidate.gender,
        street: candidate.street,
        number: candidate.number,
        complement: candidate.complement || null,
        state: candidate.state,
        city: candidate.city,
        phone: candidate.phone,
        family_income: candidate.family_income,
        email: candidate.email,
        education_level: candidate.education_level,
        notification_method: candidate.notification_method,
        postal_code: candidate.postal_code,
        created_at: new Date(candidate.created_at),
      },
    });
  }

  // 12. Popula a tabela sponsorship_slot
  console.log('Populando sponsorship slots...');
  for (const slot of data.sponsorship_slot) {
    await prisma.sponsorship_slot.create({
      data: {
        id_slot: slot.id_slot,
        sponsor_plan_id: slot.sponsor_plan_id,
        slot_state: slot.slot_state,
        slot_city: slot.slot_city,
        slot_max_income: slot.slot_max_income,
        slot_min_education_level: slot.slot_min_education_level,
        slot_quantity_available: slot.slot_quantity_available,
        slot_min_age: slot.slot_min_age,
      },
    });
  }

  // 13. Popula a tabela sponsorship_selection
  console.log('Populando sponsorship selections...');
  for (const selection of data.sponsorship_selection) {
    await prisma.sponsorship_selection.create({
      data: {
        id_selection: selection.id_selection,
        cap_candidate_id: selection.cap_candidate_id,
        slot_id: selection.slot_id,
        status_selection: selection.status_selection,
        selection_date: new Date(selection.selection_date),
        expiration_date: new Date(selection.expiration_date),
      },
    });
  }

  console.log('Banco de dados populado com sucesso!');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });