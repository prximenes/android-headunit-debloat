# 8. Fazendo com IA

Um agente de IA com acesso ao terminal (Claude Code, Codex, Cursor, Aider e semelhantes) consegue fazer quase tudo deste guia por você: diagnosticar a central, classificar os pacotes, rodar os scripts e medir o resultado. Você continua responsável por **aprovar** o que for removido e por **testar** a central entre os lotes.

## Como começar

1. Faça a [preparação](01-preparacao.md) e [ative o ADB](02-ativar-adb.md). A parte física (cabo, menu de fábrica, aceitar pop-ups) é sua.
2. Clone este repositório e abra o agente na pasta dele. O agente deve ler o [AGENTS.md](../AGENTS.md), que traz as regras de segurança.
3. Use um pedido como este:

```text
Quero fazer debloat da minha central multimídia Android seguindo este repositório.
Leia o AGENTS.md e a pasta docs/. Ela está conectada por ADB.
1. Rode o diagnóstico e o backup, e meça o desempenho atual.
2. Classifique os pacotes em: seguro remover, decidir e nunca tocar, explicando cada um.
3. Me mostre o primeiro lote e espere a minha aprovação antes de remover.
4. Depois de cada lote, espere eu testar câmera de ré, rádio, Bluetooth, volante e Android Auto/CarPlay.
No fim, meça de novo e compare.
```

## O que funcionou bem no caso real

- Pedir para o agente **mostrar a lista com o motivo de cada pacote** antes de remover.
- **Lotes pequenos**, com teste entre eles.
- Pedir para o agente **descobrir o que fica rodando** (`top`, serviços, leitores de notificação). Foi isso, e não o debloat em si, que trouxe o maior ganho: o launcher de terceiros consumia um núcleo inteiro.
- Pedir para **conferir a GPU antes de instalar apps**. Teria evitado tentar dois apps de mapa incompatíveis.

## Cuidados

- O agente **não enxerga a tela da central** se você não permitir. Ele pode ler a estrutura da tela com `uiautomator dump` (só texto) ou tirar print com `screencap`, mas peça para ele avisar antes.
- Se o agente sugerir root, ROM customizada ou mexer em outras opções do menu de fábrica, **recuse**. Está fora do escopo deste guia e é onde mora o risco real.
- Quando a central desconectar, a correção normalmente é física (USB mode ou cabo). O agente não consegue resolver sozinho.
