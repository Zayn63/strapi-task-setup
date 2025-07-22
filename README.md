# 🚀 Strapi Task Setup

This repository documents **Task 1** of the onboarding project: setting up Strapi locally, creating a sample content type, and understanding its project structure.

---

## 📌 Task Objective

- ✅ Clone the Strapi repo
- ✅ Run it locally
- ✅ Explore folder structure
- ✅ Start the admin panel
- ✅ Create a sample collection type (`task`)
- ✅ Push code to GitHub
- ✅ Document the steps in `README.md`
- ✅ Share a Loom video and pull request link

---

## 🛠️ Local Setup Instructions

### 1. Clone and Install

```bash
git clone https://github.com/Zayn63/strapi-task-setup.git
cd strapi-task-setup
npx create-strapi-app@latest my-project --no-run
cd my-project
npm install


# Strapi Task Setup

This repository contains the setup for a Strapi backend, now fully containerized using Docker for easy deployment and development.

## 📦 Features

- Strapi backend setup
- Dockerized for easy container management
- Uses official `node:18-alpine` image
- Production dependencies installed with `npm ci`
- Builds Strapi Admin Panel during container build

---

## 🚀 Quick Start (Using Docker)

### 1. Clone the Repository

```bash
git clone https://github.com/Zayn63/strapi-task-setup.git
cd strapi-task-setup

docker build -t strapi-app .


docker run -p 1337:1337 strapi-app
# Trigger CI
# Trigger CI
# Trigger CI
