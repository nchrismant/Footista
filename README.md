# Footista — Base de Données & Applications Réseau & Web

Ce projet a été réalisé dans le cadre de la 3ᵉ année de Licence Informatique à Cergy Paris Université (CYU).  
Il s’agit d’un projet de création d'une base de données relationnelle comprenant toutes les relations possibles.
Puis l'intéraction à cette base de données via un application **Réseau** et via une application **Web** nommée **Footista**, visant à gérer des données liées au football.

Le tout vise à modéliser et administrer différentes informations liées au **monde du football** : clubs, joueurs, matches, compétitions, transferts, statistiques, etc.

---

## 📌 Sommaire

- [Footista — Base de Données \& Applications Réseau \& Web](#footista--base-de-données--applications-réseau--web)
  - [📌 Sommaire](#-sommaire)
  - [🎯 Objectif du projet](#-objectif-du-projet)
  - [✨ Fonctionnalités principales](#-fonctionnalités-principales)
    - [🗄️ Base de données relationnelle](#️-base-de-données-relationnelle)
    - [🌐 Application Web Footista](#-application-web-footista)
    - [🔌 Application réseau](#-application-réseau)
  - [🧩 Structure du projet / Architecture](#-structure-du-projet--architecture)
  - [🚀 Installation \& Déploiement](#-installation--déploiement)
    - [Prérequis](#prérequis)
    - [Cloner le dépôt](#cloner-le-dépôt)
    - [1. Base de données](#1-base-de-données)
    - [2. Application réseau](#2-application-réseau)
    - [3. Application web](#3-application-web)
  - [🛠️ Technologies \& Outils utilisés](#️-technologies--outils-utilisés)
  - [👥 Auteurs \& Licence](#-auteurs--licence)

---

## 🎯 Objectif du projet

Le projet Footista a pour but de :

- Concevoir et créer une **base de données relationnelle complète**, intégrant toutes les relations pertinentes du domaine footballistique.
  Développer deux applications complémentaires :  
  - une **application réseau**, pour exécuter des requêtes, gérer des données et communiquer avec le serveur ;  
  - une **application Web**, nommée *Footista*, pour fournir une interface utilisateur moderne et accessible.  
- Permettre la **gestion, consultation et mise à jour** des informations stockées.  
- Apprendre et mettre en œuvre les concepts de base de données.
- Respecter les notions de **modélisation**, de **communication réseau**, de **sécurité** et de **structuration logicielle**.

---

## ✨ Fonctionnalités principales

### 🗄️ Base de données relationnelle

- Tables représentant les éléments essentiels du football :  
  - Clubs  
  - Joueurs  
  - Matchs  
  - Compétitions
  - Trophées
  - Statistiques de match  
  - Transferts  
  - Etc.  
- Relations complexes :  
  - 1-N, N-N, contraintes d’intégrité, clés étrangères, cascades, etc.  
- Scripts SQL pour création, remplissage et tests.

### 🌐 Application Web Footista

- Interface de consultation des clubs, joueurs, matchs…  
- Formulaires d’ajout / modification / suppression des données.  
- Système de navigation clair entre entités.  
- Représentation des relations (ex : afficher les joueurs d'un club).  
- Pages Web dynamiques connectées à la base.

### 🔌 Application réseau

- Communication cliente/serveur pour envoyer des requêtes SQL.  
- Gestion centralisée des opérations sur la base.  
- Interface permettant des requêtes personnalisées.  
- Modules de lecture, insertion, suppression et mise à jour.

---

## 🧩 Structure du projet / Architecture

Le projet est organisé de la façon suivante :

```text
/ (racine)
 ├── DDL_projet.sql # Script SQL (création, insertion)
 ├── Jeu de Données/ # Données utilisées pour remplir la base de données
 ├── Réseau/ # Application réseau
    ├── src/
        ├── JDBC2.java # Connexion à la base de données
        ├── ClientTCP.java # Intéraction coté client
        └── ServeurTCP.java # Intération coté serveur
 └── Web/ # Application web
    ├── class/ # Classes PHP — logique métier
    ├── index.php, joueurs.php, clubs.php, nationales.php, login.php, logout.php …  # Fichiers PHP pages principales
    ├── include/ # Includes PHP (fonctions, classes utilitaires, header/footer)
    ├── images/ fonts/ # Ressources visuelles
    └── … # Autres ressources, traitement, etc.  
```

Cette structure permet de séparer **logique (back-end / modèle)**, **présentation (vue)** et **données (base)** — un bon point pour la maintenabilité.

---

## 🚀 Installation & Déploiement

### Prérequis

- Serveur réseau Java
- Serveur Web compatible PHP (version 7.x / 8.x)  
- Serveur de base de données (MySQL, MariaDB ou autre compatible SQL)  

### Cloner le dépôt

   ```bash
   git clone https://github.com/nchrismant/Footista.git
   cd Footista
   ```

### 1. Base de données

1. Importer la base de données via le fichier SQL fourni `DDL_projet.sql`.

### 2. Application réseau

1. Compiler et lancer le serveur (Java ou autre selon implémentation).
2. Lancer le client et se connecter au serveur.
3. Effectuer des requêtes ou gérer les données.

### 3. Application web

1. Configurer l’accès à la base de données dans un fichier de configuration (dans une classe PHP à mettre dans le dossier `class/`).
2. Déployer les fichiers sur un serveur Web (local ou hébergé).
3. Ouvrir le navigateur sur l’adresse du site — vous devriez accéder à l’interface Footista.

---

## 🛠️ Technologies & Outils utilisés

| Technologie         | Rôle              |
| ------------------- | ----------------- |
| **MySQL**           | Base de données |
| **Java**            | Application réseau |
| **Eclipse**         | IDE recommandé |
| **PHP**             | Application web côté serveur |
| **JavaScript**      | Application web côté client |
| **HTML / CSS**      | Interface web (avec deux feuilles de style : standard & alternatif) |
| **Hébergement web** | Déploiement du site |
| **TCP / Socket / HTTP** | Communication |

---

## 👥 Auteurs & Licence

- **AFATCHAWO Koffi Junior** — Étudiant L3 Informatique, Cergy Paris Université.
- **Nathan Chrismant** — Étudiant L3 Informatique, Cergy Paris Université.
- **DACRUZ Mathis** — Étudiant L3 Informatique, Cergy Paris Université.

Projet distribué sous licence **Open Source**.
