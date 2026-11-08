#!/usr/bin/bash
set -euo pipefail

FEDORA_VERSION="$(rpm -E %fedora)"

### 1. Identidade (mantém ID/ID_LIKE para não quebrar ferramentas)
sed -i 's/^NAME=.*/NAME="Leo Linux"/' /usr/lib/os-release
sed -i 's/^PRETTY_NAME=.*/PRETTY_NAME="Leo Linux"/' /usr/lib/os-release

### 2. RPM Fusion (Steam e codecs)
dnf5 -y install \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_VERSION}.noarch.rpm" \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDORA_VERSION}.noarch.rpm"

### 3. Camada de jogos
dnf5 -y install steam steam-devices gamescope gamemode mangohud

### 4. Brave (repositório oficial)
# /opt é /var/opt em sistemas atômicos: instala, move para /usr/lib e recria o link no boot
mkdir -p /var/opt
dnf5 -y config-manager addrepo \
    --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
dnf5 -y install brave-browser
mv /var/opt/brave.com /usr/lib/brave.com

### 5. Escritório (LibreOffice) e ferramentas de tema
dnf5 -y install \
    libreoffice-writer libreoffice-calc libreoffice-impress \
    libreoffice-langpack-pt-BR libreoffice-kf6 \
    kvantum

### 5b. Visual estilo Aero (tudo dos repositórios do Fedora, nada baixado de fora)
# plasma-oxygen: estilo de widgets e decoração de janelas Oxygen (gradientes, brilho, sombras)
# oxygen-icon-theme: ícones Oxygen; oxygen-sounds: sons; kdialog: janelas de confirmação
dnf5 -y install plasma-oxygen oxygen-icon-theme oxygen-sounds kdialog

### 6. Scripts e serviços do Leo Linux
# (o upload pelo navegador/Windows perde a permissão de execução, então ajustamos aqui)
chmod +x /usr/bin/leo-session /usr/bin/leo-gamemode-session \
         /usr/bin/leo-gamemode-launcher \
         /usr/bin/steamos-session-select /usr/libexec/leo-session-apply
chmod +x /etc/skel/Desktop/*.desktop
systemctl enable leo-session-switch.path

### 7. Limpeza
dnf5 clean all
rm -rf /var/cache/dnf /tmp/* || true
