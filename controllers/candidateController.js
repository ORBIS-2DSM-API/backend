const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

// Controlador para operações CRUD de candidatos
const candidateController = {
  // Criar um novo candidato
  async createCandidate(req, res) {
    try {
      // Verificar se email ou CPF já existem
      const existingCandidate = await prisma.capture_candidate.findFirst({
        where: {
          OR: [
            { email: req.body.email },
            { cpf: req.body.cpf }
          ]
        }
      });

      if (existingCandidate) {
        // Verificar qual campo está duplicado
        if (existingCandidate.email === req.body.email) {
          return res.status(400).json({
            success: false,
            message: 'Email já cadastrado no sistema.'
          });
        }
        
        if (existingCandidate.cpf === req.body.cpf) {
          return res.status(400).json({
            success: false,
            message: 'CPF já cadastrado no sistema.'
          });
        }
      }

      // Criar novo candidato
      const newCandidate = await prisma.capture_candidate.create({
        data: {
          full_name: req.body.full_name,
          cpf: req.body.cpf,
          birth_date: req.body.birth_date,
          candidate_age: req.body.candidate_age,
          gender: req.body.gender,
          street: req.body.street,
          number: req.body.number,
          complement: req.body.complement || null,
          state: req.body.state,
          city: req.body.city,
          phone: req.body.phone,
          family_income: req.body.family_income,
          email: req.body.email,
          education_level: req.body.education_level,
          notification_method: req.body.notification_method,
          postal_code: req.body.postal_code,
          created_at: new Date()
        }
      });

      return res.status(201).json({
        success: true,
        message: 'Cadastro realizado com sucesso!',
        data: newCandidate
      });
    } catch (error) {
      console.error('Erro ao criar candidato:', error);
      return res.status(500).json({
        success: false,
        message: 'Falha no envio do formulário. Por favor, tente novamente.',
        error: process.env.NODE_ENV === 'development' ? error.message : undefined
      });
    }
  },

  // Obter todos os candidatos
  async getAllCandidates(req, res) {
    try {
      const candidates = await prisma.capture_candidate.findMany();
      return res.status(200).json({
        success: true,
        data: candidates
      });
    } catch (error) {
      console.error('Erro ao buscar candidatos:', error);
      return res.status(500).json({
        success: false,
        message: 'Erro ao buscar candidatos',
        error: process.env.NODE_ENV === 'development' ? error.message : undefined
      });
    }
  },

  // Obter candidato por ID
  async getCandidateById(req, res) {
    try {
      const { id } = req.params;
      const candidate = await prisma.capture_candidate.findUnique({
        where: { id_cap_candidate: Number(id) }
      });

      if (!candidate) {
        return res.status(404).json({
          success: false,
          message: 'Candidato não encontrado'
        });
      }

      return res.status(200).json({
        success: true,
        data: candidate
      });
    } catch (error) {
      console.error('Erro ao buscar candidato:', error);
      return res.status(500).json({
        success: false,
        message: 'Erro ao buscar candidato',
        error: process.env.NODE_ENV === 'development' ? error.message : undefined
      });
    }
  },

  // Atualizar candidato
  async updateCandidate(req, res) {
    try {
      const { id } = req.params;
      
      // Verificar se o candidato existe
      const existingCandidate = await prisma.capture_candidate.findUnique({
        where: { id_cap_candidate: Number(id) }
      });

      if (!existingCandidate) {
        return res.status(404).json({
          success: false,
          message: 'Candidato não encontrado'
        });
      }

      // Verificar se email ou CPF já existem em outro registro
      if (req.body.email !== existingCandidate.email || req.body.cpf !== existingCandidate.cpf) {
        const duplicateCheck = await prisma.capture_candidate.findFirst({
          where: {
            OR: [
              { email: req.body.email },
              { cpf: req.body.cpf }
            ],
            NOT: {
              id_cap_candidate: Number(id)
            }
          }
        });

        if (duplicateCheck) {
          if (duplicateCheck.email === req.body.email) {
            return res.status(400).json({
              success: false,
              message: 'Email já cadastrado no sistema.'
            });
          }
          
          if (duplicateCheck.cpf === req.body.cpf) {
            return res.status(400).json({
              success: false,
              message: 'CPF já cadastrado no sistema.'
            });
          }
        }
      }

      // Atualizar candidato
      const updatedCandidate = await prisma.capture_candidate.update({
        where: { id_cap_candidate: Number(id) },
        data: {
          full_name: req.body.full_name,
          cpf: req.body.cpf,
          birth_date: req.body.birth_date,
          candidate_age: req.body.candidate_age,
          gender: req.body.gender,
          street: req.body.street,
          number: req.body.number,
          complement: req.body.complement || null,
          state: req.body.state,
          city: req.body.city,
          phone: req.body.phone,
          family_income: req.body.family_income,
          email: req.body.email,
          education_level: req.body.education_level,
          notification_method: req.body.notification_method,
          postal_code: req.body.postal_code
        }
      });

      return res.status(200).json({
        success: true,
        message: 'Cadastro atualizado com sucesso!',
        data: updatedCandidate
      });
    } catch (error) {
      console.error('Erro ao atualizar candidato:', error);
      return res.status(500).json({
        success: false,
        message: 'Falha na atualização do cadastro. Por favor, tente novamente.',
        error: process.env.NODE_ENV === 'development' ? error.message : undefined
      });
    }
  },

  // Excluir candidato
  async deleteCandidate(req, res) {
    try {
      const { id } = req.params;
      
      // Verificar se o candidato existe
      const existingCandidate = await prisma.capture_candidate.findUnique({
        where: { id_cap_candidate: Number(id) }
      });

      if (!existingCandidate) {
        return res.status(404).json({
          success: false,
          message: 'Candidato não encontrado'
        });
      }

      // Excluir candidato
      await prisma.capture_candidate.delete({
        where: { id_cap_candidate: Number(id) }
      });

      return res.status(200).json({
        success: true,
        message: 'Cadastro excluído com sucesso!'
      });
    } catch (error) {
      console.error('Erro ao excluir candidato:', error);
      return res.status(500).json({
        success: false,
        message: 'Falha na exclusão do cadastro. Por favor, tente novamente.',
        error: process.env.NODE_ENV === 'development' ? error.message : undefined
      });
    }
  },

  // Verificar duplicidade de email ou CPF
  async checkDuplicate(req, res) {
    try {
      const { email, cpf } = req.body;
      
      if (!email && !cpf) {
        return res.status(400).json({
          success: false,
          message: 'Email ou CPF são necessários para verificação'
        });
      }

      const whereClause = {
        OR: []
      };

      if (email) {
        whereClause.OR.push({ email });
      }

      if (cpf) {
        whereClause.OR.push({ cpf });
      }

      const existingCandidate = await prisma.capture_candidate.findFirst({
        where: whereClause
      });

      if (existingCandidate) {
        let message = '';
        
        if (email && existingCandidate.email === email) {
          message = 'Email já cadastrado no sistema.';
        } else if (cpf && existingCandidate.cpf === cpf) {
          message = 'CPF já cadastrado no sistema.';
        }

        return res.status(200).json({
          success: false,
          duplicate: true,
          message
        });
      }

      return res.status(200).json({
        success: true,
        duplicate: false,
        message: 'Dados disponíveis para cadastro'
      });
    } catch (error) {
      console.error('Erro ao verificar duplicidade:', error);
      return res.status(500).json({
        success: false,
        message: 'Erro ao verificar duplicidade',
        error: process.env.NODE_ENV === 'development' ? error.message : undefined
      });
    }
  }
};

module.exports = candidateController;
