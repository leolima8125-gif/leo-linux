# Leo Linux

Sistema atômico para jogos, baseado no Fedora Kinoite (KDE Plasma oficial do Fedora).

- Base: `quay.io/fedora/fedora-kinoite` (kernel, Mesa e Plasma do Fedora).
- Camada própria: Steam, gamescope, GameMode, MangoHud, Brave, LibreOffice, sessões Modo Game/Desktop.
- Atualização por imagem, com rollback (`rpm-ostree rollback`).

## Modo Game <-> Desktop
- Na tela de login há duas sessões: "Plasma" e "Leo Linux - Modo Game".
- `leo-session gamemode` faz o sistema iniciar direto no Modo Game; `leo-session desktop` volta ao desktop.
- Dentro da Steam, a opção "Mudar para o Desktop" chama o mesmo mecanismo.

## Visual
- Estilo de widgets e decoração Oxygen, ícones Oxygen e esquemas de cores "Leo Aero" (claro e escuro), com blur do KWin ligado.
- Alternar claro/escuro: Configurações do Sistema -> Cores e Temas -> Cores.
- O ícone "Modo Game" fica na área de trabalho (duplo clique).

## Build local
    podman build -t leo-linux .
