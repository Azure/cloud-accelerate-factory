
# Azure Migrate-as-Code (AMaC)

This repository provides a simplified reference for automating **agentless VMware server migration** to Azure using the Azure Migrate platform.  
The scripts and workflow are adapted from Microsoft’s official Azure Migrate PowerShell samples and are intended to help teams perform **large-scale discovery, assessment, and replication** of VMware VMs without installing the Mobility Agent.

---

## 📘 Overview

The automation framework demonstrates how to:

- Connect to an existing Azure Migrate project  
- Add and manage VMware vCenter servers  
- Trigger at-scale **agentless discovery** of VMware virtual machines  
- Generate machine lists for assessment and replication  
- Enable **agentless replication** for selected VMs  
- Monitor replication and migration job progress through PowerShell  

The scripts follow a modular structure, making it easier to run end-to-end or include only the components needed for your workflow.

---

## 🧩 Components Included

- **Authentication & Setup**  
  Handles secure Azure login and project-level configuration.

- **VMware Discovery Automation**  
  Connects to vCenter, discovers VMs, and imports inventory into Azure Migrate.

- **Assessment Preparation**  
  Generates discovery metadata that can be used to create Azure readiness assessments.

- **Replication Enablement**  
  Starts agentless replication for selected VMware VMs using supported server-side replication.

- **Job Monitoring**  
  Tracks discovery, assessment, and replication jobs until completion.

---

## 📂 Intended Use

This repo is meant for:

- Teams performing **large‑scale VMware migrations**  
- Migration engineers who want to automate or streamline Azure Migrate processes  
- Factory-style migration environments running repeatable workflows  
- Environments where agentless replication is preferred over Mobility Agent installation  

---

## 🔗 Reference

The original Microsoft sample scripts are available at:  
https://github.com/Azure/azure-docs-powershell-samples/tree/master/azure-migrate/migrate-at-scale-vmware-agentles/Agentless%20VMware%20automation

---

## ⚠️ Notes

- Ensure your Azure Migrate project is configured for **agentless VMware** migration.  
- Some scripts may require updates depending on subscription settings, private endpoints, or custom enterprise policies.  
- Review variables, project IDs, resource group names, and vCenter details before running in production.

---

