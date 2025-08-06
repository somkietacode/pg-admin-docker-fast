Bien sûr, voici une proposition de fichier `README.md` pour accompagner les fichiers `Dockerfile` et `manage-pgadmin.sh`.

---

# Déploiement de pgAdmin avec Docker et Persistance

Ce projet fournit les outils nécessaires pour déployer rapidement une instance de pgAdmin 4 en utilisant Docker. Il inclut un script de gestion pour simplifier le lancement, le redémarrage et la consultation des journaux du conteneur. La configuration est conçue pour être persistante, ce qui signifie que vos serveurs enregistrés et vos paramètres seront conservés même si le conteneur est recréé.

## Prérequis

- [Docker](https://docs.docker.com/get-docker/) doit être installé et en cours d'exécution sur votre machine.

## Fichiers Inclus

- **`manage-pgadmin.sh`**: Un script shell pour gérer le cycle de vie du conteneur pgAdmin.
- **`Dockerfile`**: Un Dockerfile simple pour construire une image personnalisée de pgAdmin (optionnel, car le script utilise par défaut l'image officielle `dpage/pgadmin4`).

## Démarrage Rapide

1.  **Clonez ou téléchargez ce projet.**

2.  **Personnalisez le script de gestion :**
    Ouvrez le fichier `manage-pgadmin.sh` et modifiez les variables suivantes dans la section "Paramètres à personnaliser" :

    ```bash
    # --- Paramètres à personnaliser ---
    CONTAINER_NAME="pgadmin-persistent"
    IMAGE_NAME="dpage/pgadmin4:latest"
    PGADMIN_EMAIL="votre-email@example.com"
    PGADMIN_PASSWORD="votre-mot-de-passe-securise"
    HOST_PORT=5050
    VOLUME_NAME="pgadmin-data"
    ```

    - `PGADMIN_EMAIL` : L'adresse e-mail que vous utiliserez pour vous connecter à l'interface web de pgAdmin.
    - `PGADMIN_PASSWORD` : Le mot de passe associé à cet e-mail. **Choisissez un mot de passe fort.**
    - `HOST_PORT` : Le port sur votre machine (localhost) pour accéder à l'interface de pgAdmin. Par défaut, `5050`.

3.  **Rendez le script exécutable :**
    ```bash
    chmod +x manage-pgadmin.sh
    ```

4.  **Lancez le conteneur pgAdmin :**
    ```bash
    ./manage-pgadmin.sh run
    ```
    Le script va automatiquement télécharger l'image Docker, créer un volume pour les données persistantes et démarrer le conteneur.

5.  **Accédez à pgAdmin :**
    Ouvrez votre navigateur web et allez à l'adresse : `http://localhost:5050`. Connectez-vous avec l'e-mail et le mot de passe que vous avez configurés.

## Commandes du Script

Le script `manage-pgadmin.sh` accepte trois commandes en paramètre :

### Lancer (`run`)

Cette commande crée et démarre le conteneur pgAdmin. Elle ne doit être utilisée que la première fois. Si un conteneur du même nom existe déjà, la commande Docker échouera (ce qui est une sécurité pour éviter d'écraser une configuration existante).

```bash
./manage-pgadmin.sh run
```

### Redémarrer (`restart`)

Utilisez cette commande pour redémarrer le conteneur pgAdmin sans perdre de données. C'est utile si l'application ne répond plus ou si vous souhaitez simplement rafraîchir le service.

```bash
./manage-pgadmin.sh restart
```

### Consulter les logs (`log`)

Cette commande affiche les journaux (logs) en temps réel du conteneur pgAdmin. C'est essentiel pour le débogage en cas de problème au démarrage ou à l'exécution.

```bash
./manage-pgadmin.sh log
```

## Persistance des Données

La persistance des données (serveurs enregistrés, préférences utilisateur, etc.) est assurée par un **volume Docker**. Le script crée un volume nommé `pgadmin-data` (configurable via la variable `VOLUME_NAME`) et le monte dans le conteneur à l'emplacement `/var/lib/pgadmin`.

Toutes les données de configuration de pgAdmin sont écrites dans ce volume, qui est indépendant du cycle de vie du conteneur. Vous pouvez donc supprimer et recréer le conteneur sans perdre vos informations.

Pour lister les volumes Docker sur votre système, vous pouvez utiliser la commande :
```bash
docker volume ls
```
