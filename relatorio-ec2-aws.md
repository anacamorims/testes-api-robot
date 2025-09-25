# Relatório de Implantação: EC2 e Serverest

**Nome do membro da Squad:** Ana Carolina Amorim de Souza

**Sprint:** 6

**Data:** 25/09/2025

---

## 1. Objetivo
Descrever o passo-a-passo seguido para subir a instância EC2 na AWS e a API Serverest, incluindo a resolução de desafios e problemas encontrados durante o processo.

---

## 2. Passo a Passo para Subir a EC2

**Criação de par de chaves**
    - Criar par de chaves do tipo RAS no formato .pem
**Criação de gateway de internet**

**Associação do gateway a VPC**

**Criação de tabela de rotas gateway**

**Criação da instância EC2**  
   - Tipo de instância selecionado: t2.micro
   - Criação de Tag's: Name, Project e CostCenter
   - Sistema operacional escolhido: Amazon Linux
   - Selecionar par de chaves
   - Configurações de rede e segurança: Criação de um security group, habilitando a porta 3000, além disso permitir tráfego SSH, HTTPS e HTTP da internet e Habilitar o IP público automaticamente.

**Conexão à instância via SSH**   

**Instalação de dependências na EC2**  
   - Node.js:       
   ```bash 
   sudo yum install -y nodejs 
   ```
   - Serverest:     
   ```bash
   npx serverest@latest
   ```

---

## 3. Desafios Encontrados e Soluções

    Ao tentar criar uma instância, estava sendo retornado um erro de que não tinha permissão para criar a ec2, porém após verificar várias vezes o que havia de errado, foi percebido que uma tag estava sendo criada com nome errado, e após corrigir o nome da tag a instância foi executada normalmente.



