# Utiliser l'image officielle de pgAdmin 4
FROM dpage/pgadmin4:latest

# Définir les variables d'environnement pour l'utilisateur par défaut
# Il est recommandé de les passer lors de l'exécution pour plus de sécurité
# ENV PGADMIN_DEFAULT_EMAIL="admin@example.com"
# ENV PGADMIN_DEFAULT_PASSWORD="admin"

# Exposer le port sur lequel pgAdmin s'exécute dans le conteneur
EXPOSE 80

# Le point d'entrée du conteneur est déjà configuré dans l'image de base
