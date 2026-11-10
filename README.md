# Debloat de centrais multimídia Android

**Português** · [English](README.en.md)

Guia prático para deixar mais rápida uma central multimídia Android "genérica" (as chinesas vendidas com várias marcas: Carloer, XY Auto, ALPS, Joying, Pumpkin e muitas outras), **sem root**, só com um notebook e um cabo USB.

O guia nasceu de um caso real: uma central **Carloer F9212B** (chip **MediaTek/Autochips AC8227L**, 2 GB de RAM, Android 8.1 que se apresenta como "10"). O resultado lá foi:

| | Antes | Depois |
|---|---|---|
| CPU em uso, central parada | ~44% | ~5–7% |
| RAM disponível | ~720 MB | ~815 MB |
| Pacotes instalados | 119 | 88 |

Os comandos funcionam em praticamente qualquer central Android. O que muda de uma central para outra é **como liberar o ADB** e **quais apps são essenciais**. Este guia ensina a descobrir as duas coisas na sua.

> ⚠️ **Leia antes de começar.** Tudo aqui é reversível (nada apaga a partição do sistema e um reset de fábrica traz tudo de volta), mas remover o pacote errado pode fazer sumir rádio, câmera de ré ou comandos de volante até você desfazer. Siga a ordem dos passos, faça backup e remova em lotes pequenos. Você é responsável pelo seu aparelho.

## Para quem é

- **Quer fazer na mão:** siga os documentos em ordem. Todos os comandos estão explicados.
- **Quer fazer com ajuda de IA** (Claude Code, Cursor, Codex, Aider ou outro agente com acesso ao terminal): leia [docs/08-com-ia.md](docs/08-com-ia.md). O arquivo [AGENTS.md](AGENTS.md) traz as regras que o agente deve seguir.

## Passo a passo

1. [Preparação: o que instalar no notebook](docs/01-preparacao.md)
2. [Ativar o ADB na central](docs/02-ativar-adb.md), incluindo o menu de fábrica e o "USB mode"
3. [Backup](docs/03-backup.md)
4. [Classificar os pacotes: o que remover e o que nunca tocar](docs/04-classificar-pacotes.md)
5. [Remover em lotes e desfazer](docs/05-remover-e-reverter.md)
6. [Desempenho além do debloat](docs/06-desempenho.md): launcher, animações, apps em segundo plano, GPU
7. [Solução de problemas](docs/07-solucao-de-problemas.md)
8. [Fazendo com IA](docs/08-com-ia.md)

## Scripts

Na pasta [`scripts/`](scripts/) (bash; Linux e macOS, ou Windows via WSL/Git Bash):

| Script | O que faz |
|---|---|
| `diagnose.sh` | Mostra modelo, chip, Android, GPU, RAM e os processos que mais gastam CPU |
| `backup.sh` | Salva a lista de pacotes e as informações do aparelho numa pasta datada |
| `debloat.sh` | Remove os pacotes de um arquivo de lista e gera o script para desfazer |
| `restore.sh` | Reinstala pacotes removidos (a partir do script de rollback ou de uma lista) |
| `measure.sh` | Mede CPU e RAM por alguns segundos, para comparar antes e depois |

## Listas de pacotes

Na pasta [`lists/`](lists/) há listas comentadas do caso real (AC8227L / XY Auto) e uma lista de **pacotes que não devem ser removidos** nessas centrais. Use como ponto de partida, **nunca como verdade absoluta**: confira cada pacote na sua central antes.

Contribuições com listas de outras centrais são bem-vindas: veja [lists/README.md](lists/README.md).

## Projeto relacionado

- **EV Home**: um launcher leve, estilo carro elétrico, feito para essas centrais depois do debloat: [prximenes/ev-home-launcher](https://github.com/prximenes/ev-home-launcher).

## Licença

[MIT](LICENSE).
