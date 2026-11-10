# Listas de pacotes

**Português** · [English](README.en.md)

Formato: **um pacote por linha**. `#` inicia um comentário (a linha inteira ou o fim da linha).

```text
# comentário
com.exemplo.app          # o que é e por que remover
```

| Arquivo | Uso |
|---|---|
| `ac8227l-xyauto-seguro.txt` | Lote de baixo risco testado numa Carloer F9212B (AC8227L, XY Auto, Android 8.1) |
| `ac8227l-xyauto-decidir.txt` | Pacotes que dependem do seu uso (OTA, galeria, apps de terceiros comuns) |
| `ac8227l-xyauto-nunca-remover.txt` | Pacotes essenciais nessas centrais. **Não use com o `debloat.sh`**: é uma lista de referência |

## Como usar

```bash
cp lists/ac8227l-xyauto-seguro.txt minha-lista.txt
# edite: apague o que você quer manter
./scripts/debloat.sh minha-lista.txt
```

O `debloat.sh` pula pacotes que não estão instalados e se recusa a remover a tela inicial atual.

## Contribuindo com a sua central

Abra um pull request com um arquivo `lists/<chip>-<fabricante>-<tipo>.txt`, contendo no topo:

- modelo, chip (`ro.board.platform`) e Android real (`ro.build.version.sdk`)
- o que foi testado depois da remoção (câmera, rádio, Bluetooth, volante, espelhamento)

**Não inclua** número de série, `getprop.txt` completo ou dados pessoais.
