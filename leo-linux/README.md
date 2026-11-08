# Leo Linux

Sistema atômico para jogos baseado em Bazzite (Fedora Atomic).

## Como funciona
- Base: `ghcr.io/ublue-os/bazzite-deck` (kernel, Mesa, Steam, gamescope, modo game).
- Atualizações por imagem, com rollback no menu de boot (`rpm-ostree rollback`).
- Extras do Leo Linux: Brave, LibreOffice, Kvantum e tema estilo Aero.
- O GitHub Actions reconstrói a imagem todo dia para acompanhar a base.

## Build local
    podman build -t leo-linux .

## Instalar a partir da imagem (em um Fedora Atomic / Bazzite já instalado)
    rpm-ostree rebase ostree-unverified-registry:ghcr.io/SEU_USUARIO/leo-linux:stable
    systemctl reboot

## Modo gamer
A sessão de jogo (gamescope + Steam) e o alternador "Mudar para o Desktop" /
"Voltar ao modo Game" já vêm da base bazzite-deck.

## Próximos passos
1. Colocar os assets do tema em system_files/usr/share/leo-linux/theme.
2. Gerar uma ISO instalável (bootc-image-builder ou ISO do Universal Blue).
3. Assinar a imagem (cosign) quando for distribuir.
