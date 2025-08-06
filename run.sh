#!/bin/bash

# --- Paramètres à personnaliser ---
CONTAINER_NAME="pgadmin-persistent"
IMAGE_NAME="dpage/pgadmin4:latest"
PGADMIN_EMAIL="votre-email@example.com"
PGADMIN_PASSWORD="votre-mot-de-passe-securise"
HOST_PORT=5050
VOLUME_NAME="pgadmin-data"

# --- Fonctions ---

# Fonction pour lancer le conteneur
run_container() {
    echo "Lancement du conteneur pgAdmin..."
    docker run -d \
        --name ${CONTAINER_NAME} \
        -p ${HOST_PORT}:80 \
        -e "PGADMIN_DEFAULT_EMAIL=${PGADMIN_EMAIL}" \
        -e "PGADMIN_DEFAULT_PASSWORD=${PGADMIN_PASSWORD}" \
        -v ${VOLUME_NAME}:/var/lib/pgadmin \
        --restart=unless-stopped \
        ${IMAGE_NAME}

    echo "Conteneur pgAdmin démarré et accessible sur http://localhost:${HOST_PORT}"
}

# Fonction pour redémarrer le conteneur
restart_container() {
    echo "Redémarrage du conteneur pgAdmin..."
    docker restart ${CONTAINER_NAME}
    echo "Conteneur redémarré."
}

# Fonction pour afficher les journaux
show_logs() {
    echo "Affichage des journaux du conteneur pgAdmin..."
    docker logs ${CONTAINER_NAME}
}

# --- Logique du script ---

case "$1" in
    run)
        run_container
        ;;
    restart)
        restart_container
        ;;
    log)
        show_logs
        ;;
    *)
        echo "Usage: $0 {run|restart|log}"
        exit 1
esac

exit 0
