const express = require('express');
const router = express.Router();
const candidateController = require('../controllers/candidateController');
const { body, validationResult } = require('express-validator');

// Middleware para validação dos campos do formulário
const validateCandidate = [
  body('full_name').notEmpty().withMessage('Nome completo é obrigatório'),
  body('cpf').notEmpty().withMessage('CPF é obrigatório')
    .matches(/^\d{3}\.\d{3}\.\d{3}-\d{2}$/).withMessage('Formato de CPF inválido'),
  body('birth_date').notEmpty().withMessage('Data de nascimento é obrigatória'),
  body('candidate_age').isInt({ min: 0 }).withMessage('Idade inválida'),
  body('gender').isIn(['M', 'F', 'O']).withMessage('Gênero inválido'),
  body('street').notEmpty().withMessage('Rua é obrigatória'),
  body('number').notEmpty().withMessage('Número é obrigatório'),
  body('state').notEmpty().withMessage('Estado é obrigatório'),
  body('city').notEmpty().withMessage('Cidade é obrigatória'),
  body('phone').notEmpty().withMessage('Telefone é obrigatório')
    .matches(/^\(\d{2}\) \d{5}-\d{4}$/).withMessage('Formato de telefone inválido'),
  body('family_income').isFloat({ min: 0 }).withMessage('Renda familiar inválida'),
  body('email').isEmail().withMessage('Email inválido'),
  body('education_level').notEmpty().withMessage('Nível de escolaridade é obrigatório'),

  // Middleware para verificar erros de validação
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ 
        success: false, 
        message: 'Erro de validação', 
        errors: errors.array() 
      });
    }
    next();
  }
];

// Rotas para o CRUD de candidatos
router.post('/', validateCandidate, candidateController.createCandidate);
router.get('/', candidateController.getAllCandidates);
router.get('/:id', candidateController.getCandidateById);
router.put('/:id', validateCandidate, candidateController.updateCandidate);
router.delete('/:id', candidateController.deleteCandidate);

// Rota para verificar se email ou CPF já existem
router.post('/check-duplicate', candidateController.checkDuplicate);

module.exports = router;
