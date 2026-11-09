# 4. Classificar os pacotes

O objetivo é separar os pacotes em três grupos: **remover**, **decidir** e **nunca tocar**.

## Como investigar um pacote

```bash
adb shell pm list packages -3                    # instalados depois (terceiros)
adb shell dumpsys package com.exemplo | grep -E "versionName|codePath|firstInstallTime|installerPackageName"
```

- `codePath=/system/...` ou `/vendor/...` → veio de fábrica.
- `codePath=/data/app/...` → instalado depois (por você, pelo vendedor ou pelo dono anterior).
- `installerPackageName=com.android.vending` → veio da Play Store.
- `firstInstallTime` muito diferente dos outros → pode ser algo instalado sem você saber.

Qual app é a tela inicial (nunca remova sem trocar antes):

```bash
adb shell cmd package resolve-activity --brief -a android.intent.action.MAIN -c android.intent.category.HOME
```

## 🟢 Geralmente seguro remover

| Tipo | Exemplos |
|---|---|
| Testes e demos de fábrica | `*.autotest`, `com.example.*` |
| Loggers de debug | `com.mediatek.mtklogger`, `com.mediatek.mtklogger.proxy` |
| Apps Google que ninguém usa no carro | Assistente, Feedback, Partner Setup, Backup Transport, Config Updater |
| Apps de celular sem sentido no carro | Exchange, gravador de som, visualizador HTML, favoritos do navegador |
| Lembretes e utilitários de fábrica | `com.bumblebee.remindeasy`, calculadora |

## 🟡 Decida caso a caso

- **Verificador de atualização OTA** (`*.otacheck`): se removido, a central deixa de receber atualizações do fabricante.
- **Galeria**: só se você não abre fotos pela central.
- **Apps de terceiros** (Spotify, Waze, navegadores): são seus, a decisão é sua.
- **Launchers de terceiros** pesados (ex.: CarWebGuru): veja [6. Desempenho](06-desempenho.md).

## 🔴 Nunca remova (centrais AC8227L / XY Auto)

| Função | Pacotes típicos |
|---|---|
| Câmera de ré e entradas de vídeo | `com.autochips.android.backcar` |
| Bluetooth do carro | `com.autochips.bluetooth`, `com.android.bluetooth` |
| CAN bus e comandos do carro | `com.xygala.*`, `com.pve.apsbridge`, `com.pve.appsetting` |
| Chip de áudio e equalizador | `com.xy.tda7729` |
| Configurações do fabricante | `com.xyauto.Settings` |
| Rádio, música e vídeo de fábrica | `com.acloud.stub.*` |
| Espelhamento (Android Auto/CarPlay) e ativação | `com.zjinnova.zlink`, `com.xy.zlinkactivationcode`, `com.kyhero.car.myhost*` |
| Dash cam | `com.williexing.*` |
| Trava de vídeo em movimento | `com.xy.brakecheck` |
| GPS, teclado e sistema | `com.mediatek.ygps`, `com.android.systemui`, `com.android.settings`, `com.android.phone`, os `providers` |
| Launcher de fábrica | `com.android.launcher` (mesmo que você use outro, mantenha como reserva) |

Em **outras plataformas**, procure os equivalentes: tudo com nome do fabricante (`fyt`, `syu`, `microntek`, `hct`, `ts10`), "can", "canbus", "mcu", "radio", "backcar", "avin", "bt".

> Na dúvida, **não remova**. Pacote pequeno parado não pesa nada. O que pesa são os poucos que ficam rodando (veja [6. Desempenho](06-desempenho.md)).

Próximo: [5. Remover e desfazer](05-remover-e-reverter.md)
