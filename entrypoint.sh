#!/bin/sh
echo "Démarrage du conteneur..."

# Attente que la base de données soit prête
until mysql -h "db" -u "wave-user" -p"wave23" -e "SHOW DATABASES;" > /dev/null 2>&1; do
  echo "En attente que la base de données soit prête..."
  sleep 2
done

echo "Base de données prête. Installation de la dépendance doctrine/dbal..."

# Installer la dépendance doctrine/dbal
composer require doctrine/dbal

echo "Dépendance doctrine/dbal installée. Lancement des migrations..."

# Exécuter les migrations
php artisan migrate --force

# Seed des données
php artisan db:seed --force

# Vider les caches de Laravel
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear

# Lancer le service PHP-FPM
exec php-fpm
