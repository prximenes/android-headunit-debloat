# 6. Desempenho além do debloat

## Meça antes e depois

```bash
./scripts/measure.sh        # CPU e RAM por ~30 s
./scripts/diagnose.sh       # inclui os processos que mais gastam CPU
```

Meça sempre no mesmo estado (por exemplo, 10 minutos depois de ligar, sem música). No caso real, a maior lição foi: **sem medir antes, não dá para provar o ganho depois.**

## 1. O launcher costuma ser o vilão

No caso real, o launcher de terceiros (CarWebGuru) usava **~92% de um núcleo o tempo todo**, mais do que tudo o resto junto. Ele mantinha GPS em alto consumo, serviço de música e um leitor de notificações.

Teste: troque temporariamente para o launcher de fábrica e meça.

```bash
# listar launchers disponíveis
adb shell cmd package query-activities --brief -a android.intent.action.MAIN -c android.intent.category.HOME
# definir a tela inicial (exemplo com o launcher de fábrica)
adb shell cmd package set-home-activity com.android.launcher/com.android.launcher2.Launcher
adb shell input keyevent KEYCODE_HOME
```

### Apps que voltam sozinhos

Mesmo fora da tela, um app pode ser reaberto pelo sistema se tiver um **leitor de notificações** ativo:

```bash
adb shell settings get secure enabled_notification_listeners
adb shell cmd notification disallow_listener pacote/componente.Do.Listener
```

## 2. Animações em 0,5×

Deixa a central mais ágil ao abrir e trocar de app:

```bash
adb shell settings put global window_animation_scale 0.5
adb shell settings put global transition_animation_scale 0.5
adb shell settings put global animator_duration_scale 0.5
# desfazer: settings delete global <nome>
```

## 3. Bloquear a Play Store em segundo plano

Mantém a loja funcionando quando você abre, mas evita trabalho por conta própria:

```bash
adb shell cmd appops set com.android.vending RUN_IN_BACKGROUND ignore
# desfazer: ... RUN_IN_BACKGROUND allow
```

## 4. Antes de instalar apps: veja a GPU

Muitas centrais baratas têm GPUs antigas. O AC8227L tem uma **Mali-450, só com OpenGL ES 2.0**:

```bash
adb shell dumpsys SurfaceFlinger | grep GLES
```

Apps modernos de mapa que **exigem OpenGL ES 3** travam ao abrir nessas GPUs. No caso real, o Organic Maps fechava com `OpenGL ES3 is not supported`, e o OsmAnd também travava. Também não funcionou: HERE WeGo (o motor dele exige ES3). O MapFactor Navigator, que desenha pelo processador em telas abaixo de Full HD, abriu sem travar.

Em geral, nessas centrais, **navegar pelo celular via Android Auto/CarPlay** é melhor do que qualquer app de mapa instalado na própria central.

## 5. O que não fazer

- **Limitar processos em segundo plano** nas Opções do desenvolvedor: costuma quebrar Bluetooth, rádio e espelhamento.
- **Mudar o governor da CPU** ou outras opções de kernel: na maioria das centrais já está em `performance`, e mexer exige root.
- **Instalar ROMs customizadas** sem saber recuperar a central: há risco real de travar o aparelho de vez.

Próximo: [7. Solução de problemas](07-solucao-de-problemas.md)
