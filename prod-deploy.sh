#!/bin/bash

BRANCH=deploy

echo "deploying application..."
echo "getting application from $BRANCH"

(php artisan down)
  git fetch origin $BRANCH
  git reset --hard origin/$BRANCH

  composer install --no-interaction --prefer-dist --optimize-autoloader

  php artisa migrate --force

  php artisan optimize

  echo "" | sudo -S systemctl restart php8.3-fpm

php artisan up
echo "application deployed!"
