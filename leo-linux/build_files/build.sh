#!/usr/bin/bash
set -euo pipefail

### 1. Identidade do sistema (mantém ID/ID_LIKE para não quebrar ferramentas)
sed -i 's/^NAME=.*/NAME="Leo Linux"/' /usr/lib/os-release
sed -i 's/^PRETTY_NAME=.*/PRETTY_NAME="Leo Linux"/' /usr/lib/os-release

### 2. Brave (repositório oficial)
# Em sistemas atômicos /opt é /var/opt, que não faz parte da imagem.
# Instalamos em /var/opt, movemos para /usr/lib e recriamos o link no boot.
mkdir -p /var/opt
dnf5 -y config-manager addrepo \
    --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
dnf5 -y install brave-browser
mv /var/opt/brave.com /usr/lib/brave.com
# (o link /var/opt/brave.com é criado por system_files/usr/lib/tmpfiles.d/leo-brave.conf)

### 3. Pacote de escritório (LibreOffice, em vez do Apache OpenOffice)
dnf5 -y install \
    libreoffice-writer libreoffice-calc libreoffice-impress \
    libreoffice-langpack-pt-BR libreoffice-kf6

### 4. Ferramentas de tema (Aero)
dnf5 -y install kvantum


### 6. Limpeza
dnf5 clean all
rm -rf /var/cache/dnf /tmp/* || true
