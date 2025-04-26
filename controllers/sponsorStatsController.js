const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const getSponsorStats = async (req, res) => {
  const sponsorId = parseInt(req.params.id);

  try { 
    // Busca todas as sponsor_plan do patrocinador
    const sponsorPlans = await prisma.sponsor_plan.findMany({
      where: {
        sponsor_id: sponsorId
      },
      select: {
        id_sponsor_plan: true
      }
    });

    const sponsorPlanIds = sponsorPlans.map(plan => plan.id_sponsor_plan);

    // Busca os owners ligados a essas sponsor_plans
    const owners = await prisma.owner_sponsor_plan.findMany({
      where: {
        sponsor_plan_id: {
          in: sponsorPlanIds
        }
      },
      select: {
        owner_id: true
      }
    });

    const ownerIds = owners.map(o => o.owner_id);

    // Conta os usuários impactados (relacionados aos owners)
    const impactedUsers = await prisma.users.count({
      where: {
        owner_id: {
          in: ownerIds
        }
      }
    });

    // Conta as lojas criadas por esses owners
    const totalStores = await prisma.store.count({
      where: {
        owner_id: {
          in: ownerIds
        }
      }
    });

    const totalCommunities = await prisma.community.count({
      where: {
        owner_id: {
          in:
          ownerIds
        }
      }
    });

    res.json({
      sponsorId,
      impactedUsers,
      totalStores,
      totalCommunities
    });
  } catch (error) {
    console.error('Erro ao buscar estatísticas:', error);
    res.status(500).json({ error: error.message });
  }
};

module.exports = {
  getSponsorStats
};
