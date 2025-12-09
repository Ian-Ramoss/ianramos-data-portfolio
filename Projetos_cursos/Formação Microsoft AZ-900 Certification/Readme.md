# Criando uma Máquina Virtual no Microsoft Azure

Este repositório contém um guia rápido e resumido sobre como criar uma **Máquina Virtual (VM)** no Microsoft Azure. O conteúdo segue os passos aprendidos nos cursos da **DIO (Digital Innovation One)**, durante o módulo de computação em nuvem com Azure.

---

## 🧩 Pré-requisitos

Antes de criar sua VM, você precisa:

- Uma conta ativa no [Microsoft Azure](https://portal.azure.com/).
- Créditos disponíveis (plano gratuito ou assinatura educacional da DIO).
- Conhecimentos básicos sobre:
  - Resource Group
  - Regiões
  - Tamanho e tipo de máquina

---

## 🚀 Passo a Passo: Criando uma VM no Azure

### 1. Acessar o Portal Azure
- Acesse: https://portal.azure.com  
- No menu lateral, clique em **"Máquinas Virtuais" (Virtual Machines)**.

### 2. Criar nova VM
- Clique em **“Criar” > “Máquina Virtual do Azure”**.

### 3. Configurar a guia **Basics**
Preencha as seguintes informações:

1. **Subscription:** sua assinatura.  
2. **Resource Group:** escolha um grupo existente ou crie um novo.  
3. **Virtual Machine Name:** nome da VM.  
4. **Region:** escolha a região desejada (ex.: *East US*, *Brazil South*).  
5. **Image:** escolha o sistema operacional (Ubuntu, Windows Server, etc.).  
6. **Size:** selecione o tamanho da máquina (ex.: B1s para testes).  
7. **Authentication Type:**  
   - SSH (para Linux)  
   - Password (para Windows)  
8. Crie usuário, senha/chave SSH e escolha as portas abertas (22 para SSH, 3389 para RDP).

---

## 💽 Configuração de Discos

Na guia **Disks**, escolha o tipo de disco:

- **Standard HDD** (mais barato)  
- **Standard SSD** (recomendado)  
- **Premium SSD** (alta performance)

---

## 🌐 Configuração de Rede

Na guia **Networking**, configure:

- **Virtual Network (VNet)** e **Subnet**  
- Se a VM terá **IP público**  
- Regras de firewall (Network Security Groups)  
  - Porta 22 (SSH) — Linux  
  - Porta 3389 (RDP) — Windows

---

## ✔️ Revisão e Criação

- Na guia **Review + Create**, revise todas as configurações.
- Clique em **Create**.
- Aguarde a implantação ser concluída.

---

## 🖥️ Como Acessar a VM

### Linux (via SSH)
```bash
ssh seu-usuario@seu-ip-publico
