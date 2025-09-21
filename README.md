#  Projet Data Visualisation — Subventions par Organisme

## Objectif du projet

Ce projet vise à créer un **dashboard complet dans Metabase** pour visualiser des données de subventions attribuées à différents organismes (associations, écoles, centres sociaux, etc.).  
L’objectif est de mettre en place une **chaîne complète de datavisualisation locale**, depuis la création de la base de données PostgreSQL jusqu’à la mise en forme graphique des analyses dans Metabase.

---

## Stack technique

- **PostgreSQL** : Base de données relationnelle locale (VM Debian 12)
- **Metabase** : Plateforme de datavisualisation libre, installée sur la même VM
- **Docker (facultatif)** : Non utilisé ici mais peut être adapté à la stack
- **DBeaver** : Utilisé pour vérifier la base et requêter
- **Git** : Versionnage du projet sur GitHub

---

##  Structure du projet

metabase/
├── README.md
├── sql/
│ ├── create_table.sql # Création de la table subventions
│ ├── insert_data.sql # Données injectées (environ 500 lignes générées)
├── screenshots/
│ ├── dashboard_principal.png
│ ├── graph_1_organismes.png
│ ├── graph_2_mensuel.png
│ └── ...
└── exports/
└── Requêtes_SQL_Metabase.txt # Export ou copie des requêtes utilisées

pgsql
Copier
Modifier

---

##  Étapes réalisées

### 1. Création de la base de données

- Installation de PostgreSQL sur une VM Debian 12
- Création d’une base `subventions_db`
- Création d’une table `subventions` avec les champs :
  - `id` (clé primaire)
  - `organisme` (texte)
  - `objet` (texte – type de finalité)
  - `montant` (entier)
  - `date_versement` (date)

Voir `sql/create_table.sql` pour le détail.

---

### 2. Injection des données

- Génération de **plus de 500 lignes réalistes** simulant des versements de subventions entre 2020 et 2024
- Insertion via fichier `.sql` :  
  ➤ `sql/insert_data.sql`

---

### 3. Connexion de Metabase

- Lancement de Metabase localement sur `localhost:3000`
- Connexion à la base PostgreSQL locale via l’interface
- Vérification des champs, typage correct des colonnes (`Date`, `Montant`, etc.)

---

### 4. Création du Dashboard

Nom : **Association Sportive**

###  Graphiques inclus :

1. **Évolution mensuelle du montant des subventions**
   - Groupé par `organisme`
   - Requête : `GROUP BY organisme`

2. **Nombre de subventions accordées par organisme**
   - Graphique en barres cumulées
   - Compte les lignes par organisme

3. **Montant total des subventions versées par mois**
   - Série temporelle
   - Requête : `GROUP BY date_trunc('month', date_versement)`

4. **Montant total par finalité (objet)**
   - Affiche la somme par type d’objet :
     - Travaux de rénovation
     - Soutien scolaire
     - Projet d’inclusion
     - etc.

###  Visualisation disponible sur plusieurs pages (onglet 1, 2, etc.)

---

##  Exemples de requêtes SQL utilisées dans Metabase

```sql
-- Total des subventions par organisme
SELECT organisme, SUM(montant) AS total
FROM subventions
GROUP BY organisme
ORDER BY total DESC;

-- Subventions mensuelles pour l’Association Sportive
SELECT date_trunc('month', date_versement) AS mois, SUM(montant) AS total
FROM subventions
WHERE organisme = 'Association Sportive'
GROUP BY mois
ORDER BY mois;

-- Nombre de subventions par organisme
SELECT organisme, COUNT(*) AS nombre
FROM subventions
GROUP BY organisme
ORDER BY nombre DESC;

-- Total par objet
SELECT objet, SUM(montant) AS total_subventions
FROM subventions
GROUP BY objet
ORDER BY total_subventions DESC;

------##  Captures d’écran
Les visuels du dashboard sont disponibles dans screenshots/.

----##  Déploiement local
bash
Copier
Modifier
# Lancer PostgreSQL
sudo service postgresql start

# Vérifier la base et injecter les données
psql -U postgres -d subventions_db -f sql/create_table.sql
psql -U postgres -d subventions_db -f sql/insert_data.sql

# Accéder à Metabase
http://localhost:3000

------ ## Auteur
Projet réalisé dans le cadre d’une formation DevOps / Data, avec pour objectif :

-de comprendre la logique de datavisualisation

-de se familiariser avec les requêtes SQL métier

-d’être capable d’exposer des indicateurs métiers clairs et dynamiques
