# 1. Preparação

## No notebook

Você só precisa do **ADB** (Android Debug Bridge), a ferramenta oficial do Google para conversar com aparelhos Android.

**Linux (Debian/Ubuntu):**

```bash
sudo apt install adb
```

**macOS (Homebrew):**

```bash
brew install android-platform-tools
```

**Windows:** baixe o *SDK Platform-Tools* no site oficial do Android (developer.android.com/tools/releases/platform-tools), extraia e use o `adb.exe` de dentro da pasta. Para rodar os scripts deste repositório, use o WSL ou o Git Bash.

Confira:

```bash
adb version
```

### Opcional: UAD-ng

O [Universal Android Debloater Next Generation](https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation) é uma interface gráfica sobre o ADB com uma lista de pacotes classificados. Ele ajuda em celulares, mas cobre pouco as centrais chinesas: a maioria dos pacotes delas aparece como "Unlisted". Este guia não depende dele.

## Leve para o carro

- **Cabo USB de dados.** Muitos cabos só carregam. Teste antes com um celular: se o notebook não enxerga o celular (`adb devices` ou `lsusb`), o cabo não serve.
- O tipo de cabo depende das portas: normalmente USB-A (notebook) para USB-A ou USB-C (central).
- Notebook com bateria. O processo leva de 30 minutos a algumas horas.

## Na central: anote antes

Em **Configurações → Sobre** (ou "Informações do sistema"), anote:

- Modelo e "device" (ex.: `8227L_demo`, `ums512_1h10`)
- Versão do Android e do MCU
- Chip, se aparecer

Isso ajuda a achar informações específicas do seu modelo e a escolher a lista de pacotes certa.

Próximo: [2. Ativar o ADB](02-ativar-adb.md)
