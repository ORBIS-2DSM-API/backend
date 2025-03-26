import { PrismaClient } from '@prisma/client';
import * as fs from 'fs';

// Definir a interface para o formato do JSON
interface DatabaseData {
  planData: Array<{
    plan_id_bd: number;
    planName: string;
    planActive: boolean;
    productInStore: number;
    storeQuantity: number;
    communityQuantity: number;
    price: number;
  }>;
  sponsor: Array<{
    sponsor_id_bd: number;
    descriptionSponsor?: string;
    descriptionTitle?: string;
    expirationUrl?: string;
    facebook?: string;
    highSponsorLogo?: string;
    instagram?: string;
    kawai?: string;
    linkedin?: string;
    lowSponsorLogo?: string;
    nameSponsor: string;
    site_web?: string;
    tiktok?: string;
    urlSponsor?: string;
    whatsapp?: string;
    x?: string;
  }>;
  owner: Array<{
    owner_id_bd: number;
    storeOwnerId?: number;
    owner_name: string;
  }>;
  store: Array<{
    store_id_bd: number;
    storeId?: string;
    storeCategory?: string;
    storeName: string;
    shortDescription?: string;
    isActive: boolean;
    affiliateStore: boolean;
    productLikeStore: boolean;
    storeAffiliateLink?: string;
    data_criacao?: string; // String no JSON, será convertido para DateTime
    owner_owner_id_bd?: number;
  }>;
  community: Array<{
    community_id_bd: number;
    placeId?: number;
    bairro?: string;
    cep?: string;
    cidade: string;
    condominio?: string;
    endereco?: string;
    estado: string;
    geoPoint?: string;
    local?: string;
    tipoLocal?: string;
    owner_owner_id_bd?: number;
  }>;
  usuario: Array<{
    user_id_bd: number;
    owner_owner_id_bd?: number;
  }>;
  sponsor_owner_plan: Array<{
    sponsor_sponsor_id_bd: number;
    planData_plan_id_bd: number;
    data_inicio: string; // Será convertido para DateTime
    data_fim?: string; // Será convertido para DateTime
  }>;
  owner_community: Array<{
    owner_owner_id_bd: number;
    community_community_id_bd: number;
  }>;
  usuario_community: Array<{
    usuario_user_id_bd: number;
    community_community_id_bd: number;
  }>;
}

const prisma = new PrismaClient();

// Lê o JSON do arquivo
const rawData: DatabaseData = JSON.parse(fs.readFileSync('../assets/json_files/data.json', 'utf8'));

// Ajusta os dados para compatibilidade com o schema Prisma
const data: DatabaseData = {
  ...rawData,
  store: rawData.store.map(store => ({
    ...store,
    data_criacao: store.data_criacao ? new Date(store.data_criacao).toISOString() : undefined,
  })),
  sponsor_owner_plan: rawData.sponsor_owner_plan.map(sop => ({
    ...sop,
    data_inicio: new Date(sop.data_inicio).toISOString(),
    data_fim: sop.data_fim ? new Date(sop.data_fim).toISOString() : undefined,
  })),
};

async function populateDatabase(): Promise<void> {
  try {
    // Inserir planData
    await prisma.planData.createMany({
      data: data.planData,
      skipDuplicates: true,
    });

    // Inserir sponsor
    await prisma.sponsor.createMany({
      data: data.sponsor,
      skipDuplicates: true,
    });

    // Inserir owner
    await prisma.owner.createMany({
      data: data.owner,
      skipDuplicates: true,
    });

    // Inserir store
    await prisma.store.createMany({
      data: data.store,
      skipDuplicates: true,
    });

    // Inserir community
    await prisma.community.createMany({
      data: data.community,
      skipDuplicates: true,
    });

    // Inserir usuario
    await prisma.usuario.createMany({
      data: data.usuario,
      skipDuplicates: true,
    });

    // Inserir sponsor_owner_plan
    await prisma.sponsor_owner_plan.createMany({
      data: data.sponsor_owner_plan,
      skipDuplicates: true,
    });

    // Inserir owner_community
    await prisma.owner_community.createMany({
      data: data.owner_community,
      skipDuplicates: true,
    });

    // Inserir usuario_community
    await prisma.usuario_community.createMany({
      data: data.usuario_community,
      skipDuplicates: true,
    });

    console.log('Dados inseridos com sucesso!');
  } catch (error) {
    console.error('Erro ao inserir dados:', error);
    throw error;
  } finally {
    await prisma.$disconnect();
  }
}

// Executa a função
populateDatabase().catch((e) => {
  console.error('Erro na execução:', e);
  process.exit(1);
});