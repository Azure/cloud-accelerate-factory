# Deploy the Azure VM Inventory Workbook

[![Deploy to Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fcustomer-success-microsoft%2Fcsu-win-mf%2Fdev%2Fazuredeploy.json)

You can deploy the workbook directly to your Azure environment using the button above.

Clicking this button will open the Azure Portal with your template pre-loaded for deployment.

1. Click the **Deploy to Azure** button above.
2. The Azure Portal will open a custom deployment blade with the workbook template pre-loaded.
3. Fill in the required fields (such as Subscription, Resource Group, Location, and Workbook Name).
4. Click **Review + create**, then **Create** to deploy the workbook.
5. After deployment, go to the selected Resource Group, find the deployed workbook under **Workbooks**, and open it.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Deployment Options](#deployment-options)
3. [Step-by-Step Deployment](#step-by-step-deployment)
4. [Permission Requirements](#permission-requirements)
5. [Workbook Structure](#workbook-structure)
6. [Filters and Scoping](#filters-and-scoping)
7. [Export and Reporting](#export-and-reporting)

---

## Quick Reference

| Task | Action |
|---|---|
| **Deploy Workbook** | Click the **Deploy to Azure** button above |
| **Required Permissions** | Contributor (deployment) + Reader (monitoring) |
| **Filter Data** | Use Subscription / Location / OS Type / Power State at the top |
| **Export Inventory** | Click **Download to Excel** (⬇) above any table |
| **Open After Deploy** | Resource Group → Workbook resource → **Open Workbook** |

---

## Prerequisites

Before deploying the Azure VM Inventory Workbook, ensure you have:

- **Azure subscription** with appropriate permissions
- **Contributor access** to the resource group where the workbook will be deployed
- **Reader permissions** across all subscriptions you want to monitor
- **Azure portal access** for deployment and operation

---

## Deployment Options

You have **two deployment methods**:

### Option 1: Deploy to Azure Button

- Click the **Deploy to Azure** button at the top of this page.

### Option 2: Azure CLI

```bash
az login
az account set --subscription "<your-subscription-id>"

az deployment group create \
  --resource-group rg-monitoring \
  --template-file azuredeploy.json \
  --parameters workbookDisplayName="Azure VM Inventory"
```

---

## Step-by-Step Deployment

### 1. Access Deployment Template

Click the **Deploy to Azure** button at the top of this page to open the ARM template in the Azure Portal.

### 2. Configure Deployment Parameters

| Parameter | Description | Action Required |
|---|---|---|
| **Subscription** | Target Azure subscription | Select appropriate subscription |
| **Resource Group** | Where the workbook will be created | Select existing or create new |
| **Region** | Azure region for workbook deployment | ⚠️ **Leave as default** |
| **Workbook Display Name** | Display name shown in Azure Monitor | Use default or customize |
| **Workbook Type** | Template type | ⚠️ **Leave as default** |
| **Source ID** | Template source identifier | ⚠️ **Leave as default** |
| **Workbook ID** | Unique GUID for the resource | ⚠️ **Leave as default** (auto-generated) |

### 3. Deploy the Workbook

1. Review all parameters
2. Click **"Review + create"**
3. Validate the configuration
4. Click **"Create"** to deploy

### 4. Access the Deployed Workbook

1. Navigate to the **resource group** where you deployed the workbook
2. Find the resource with type **"Workbook"**
3. Click on the workbook resource
4. Select **"Open Workbook"** to launch

---

## Permission Requirements

### Deployment Permissions

- **Contributor** role at the **resource group level** where the workbook will be deployed

### Operational Permissions

- **Reader** role across **all subscriptions** that will be monitored by the workbook

### Multi-Subscription Monitoring Example

If monitoring **2 subscriptions**:

- ✅ **Reader** access to Subscription A
- ✅ **Reader** access to Subscription B
- ✅ **Contributor** access to Resource Group (for deployment — can be revoked after deployment)

---
## Filters and Scoping

All tabs respond dynamically to the **five global filters** at the top of the workbook:

| Filter | Description |
|---|---|
| **Subscription** | Multi-select — defaults to all your subscriptions |
| **Resource Group** | Multi-select — dynamically populated from VMs in the selected subscription(s); defaults to all |
| **Location** | Filter by Azure region; dynamically populated from your VMs |
| **OS Type** | Windows / Linux |
| **Power State** | Running, Deallocated, Stopped, etc. |

> **Tip:** Apply filters before exporting to download only the data you need.

---

## Workbook Structure

The workbook is organized into **four main tabs**:

### 1. 📋 Overview

- **VM Inventory Summary**: Unified sortable, filterable, exportable table combining VM compute, network, and disk data across all selected subscriptions
- Columns include: VM Name, VM Size, OS Type, Power State, OS Disk, Data Disk Count, Total Storage, NICs, Private IPs, VNets, Accelerated Networking, NSGs, Tags

### 2. 🖥️ VM

Six sub-tabs covering the full compute inventory:

| Sub-tab | Contents |
|---|---|
| **Summary** | Aggregate tile counts — Total VMs, Powered On, Deallocated, Stopped, Windows VMs, Linux VMs |
| **VM Inventory** | Full VM list with SKU, OS, power state, vCPUs/Cores, ESU Billable Cores, Core Size, provisioning state, disk summary, NIC details |
| **SKU** | Bar chart + table of VM size distribution |
| **Boot Diagnostics** | Per-VM boot diagnostics status: Enabled/Disabled, Managed vs. Custom storage |
| **VM Extensions** | Installed extensions per VM with publisher, type, version, and auto-upgrade setting |
| **AHB Status** | Azure Hybrid Benefit summary + per-VM license type |
| **Core Governance** | Core Governance summary + Core Governance per VM |


### 3. 🌐 Networking

Per-NIC network configuration for each VM:

- VNet and subnet names
- NIC name and private IP address
- IP allocation method (Static / Dynamic)
- Accelerated Networking and IP Forwarding status
- Associated NSG name

### 4. 💾 Disk

Aggregated disk count and size per VM:

- OS disk size (GB) and storage type (SKU)
- Data disk count
- Total data disk storage (GB)
- Total storage (OS + data disks, GB)

---

## Export and Reporting

Every tab supports **Download to Excel** (⬇). Click the button above any table to export the current filtered view as a `.xlsx` file.
<img width="1919" height="959" alt="image" src="https://github.com/user-attachments/assets/88b82a41-e7b3-47ce-ba85-3849f683b28c" />

| Tab | Export Contents |
|---|---|
| **Overview** | Combined VM Inventory Summary |
| **VM → VM Inventory** | Full compute inventory |
| **VM → Boot Diagnostics** | Diagnostics status per VM |
| **VM → VM Extensions** | Extension details per VM |
| **VM → AHB Status** | Licensing status per VM |
| **VM → Core Governance** | vCPU's/Cores and Sizing per VM |
| **Networking** | Network interface configuration |
| **Disk** | Disk count and size per VM |

---

*Built for Azure migration and post-migration operations teams.*
