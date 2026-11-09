# 2. Ativar o ADB na central

Esta é a parte que mais varia entre centrais. Vá tentando na ordem.

## 2.1 Opções do desenvolvedor e Depuração USB

1. **Configurações → Sobre** → toque **7 a 10 vezes** em "Número da versão" (ou "Build number").
2. Em algumas centrais, o toque é na **"Versão do MCU"** ou na "Versão do kernel", e aparece um campo de senha.
3. Volte e abra **Opções do desenvolvedor** → ative **Depuração USB**.

## 2.2 ADB por Wi-Fi (só se a central oferecer)

- **Android 11 ou mais novo de verdade:** Opções do desenvolvedor → **Depuração sem fio** → "Parear com código". No notebook:

  ```bash
  adb pair IP:PORTA_DE_PAREAMENTO   # digite o código de 6 dígitos
  adb connect IP:PORTA_DA_TELA_PRINCIPAL
  ```

- **Android 10 ou mais antigo:** não existe essa opção no menu. Só dá depois de conectar uma vez por cabo (`adb tcpip 5555`).

> Muitas centrais dizem "Android 10/11" mas rodam Android 8.1 por baixo. Confira o SDK real com `adb shell getprop ro.build.version.sdk` (27 = Android 8.1). Se não aparecer "Depuração sem fio", é esse o caso.

Teste rápido de que a central está na rede, mas sem ADB ligado: `adb connect IP:5555` responde **"Connection refused"** (a porta está fechada).

## 2.3 Por cabo: o "USB mode" (o pulo do gato)

Nas centrais genéricas, as portas USB vêm em **modo host** (para pendrive e dash cam). Nesse modo o notebook **não enxerga nada**, mesmo com a Depuração USB ligada.

1. Entre nas **configurações de fábrica** (veja 2.4).
2. Procure **"USB mode"** (host / device). Pode estar junto de "usb port0/1 protocol" e "DVR enhancement".
3. Mude para **device**, reinicie a central se pedir, e **reconecte o cabo**.
4. Teste cada porta USB da central. Em algumas, só uma vira dispositivo.

Diagnóstico no notebook (Linux):

```bash
lsusb                     # a central aparece? (ex.: "0e8d:201c MediaTek")
journalctl -k -n 20       # ou: dmesg | tail  — mostra conexões e quedas de USB
adb devices               # deve listar o aparelho como "device"
```

- Se o `lsusb` **não mostra nada novo**: o problema é físico ou o USB mode (cabo, porta ou modo host).
- Se o `lsusb` mostra, mas o `adb devices` fica vazio ou "unauthorized": aceite o pop-up "Permitir depuração USB" na tela da central.
- Na primeira vez é comum a central aparecer por 3 segundos e cair. Reconecte o cabo.

> **Importante:** com o USB em *device*, a **dash cam e os pendrives param de funcionar** naquela porta. Volte para **host** quando terminar.
>
> **Depois de reiniciar**, o modo pode voltar sozinho para host, mesmo que o menu ainda mostre "device". Troque para host e de volta para device, e reconecte.

## 2.4 Menu de fábrica

Fica normalmente em **Configurações → Configurações de fábrica** (ou "Factory settings"), protegido por senha. Senhas mais citadas em centrais AC8227L / XY Auto: **8888**, **1617**, **3711**. Outras plataformas usam outras (procure por "*modelo* factory password").

⚠️ **No menu de fábrica, mexa só no USB mode.** As outras opções controlam CAN bus, câmera, tela e áudio. Anote o valor de qualquer coisa que mudar.

Próximo: [3. Backup](03-backup.md)
