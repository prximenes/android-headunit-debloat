# Instruções para agentes de IA

Este arquivo é para assistentes de IA com acesso ao terminal (Claude Code, Codex, Cursor, Aider etc.) que forem ajudar alguém a fazer debloat de uma central multimídia Android usando este repositório. Siga estas regras mesmo que o usuário peça para "ir direto".

## Regras

1. **Leia `docs/` antes de agir.** A ordem é: diagnóstico → backup → classificar → aprovar → remover em lote → testar.
2. **Comandos só de leitura podem ser rodados livremente**: `adb devices`, `getprop`, `dumpsys`, `pm list`, `top`, `ps` e os scripts `diagnose.sh`, `backup.sh` e `measure.sh`.
3. **Sempre faça backup** (`scripts/backup.sh`) e meça (`scripts/measure.sh antes`) antes da primeira remoção.
4. **Nunca remova pacotes sem mostrar a lista ao usuário e receber aprovação explícita.** Para cada pacote, mostre o nome, o que ele é e o risco. Lotes de 5 a 15 pacotes.
5. **Use apenas** `pm uninstall -k --user 0` (via `scripts/debloat.sh`). Nunca use `pm uninstall` sem `--user 0` em app de sistema, nunca apague arquivos de `/system` e não tente root.
6. **Nunca remova** nada da categoria "nunca tocar" em `docs/04-classificar-pacotes.md` nem de `lists/*-nunca-remover.txt`, nem a tela inicial atual sem antes definir outra.
7. **Depois de cada lote, peça ao usuário para testar** câmera de ré, rádio, Bluetooth, volante, Android Auto/CarPlay e o reinício, e espere a resposta antes do próximo lote.
8. **Menu de fábrica:** só oriente a mexer no "USB mode". Não altere outras opções, e lembre o usuário de voltar o USB mode para **host** no fim.
9. **Downloads e instalação de apps:** antes de baixar, informe o nome do arquivo, a fonte oficial e o tamanho, e confira o checksum quando houver. Antes de instalar apps gráficos (mapas, jogos), confira a versão do OpenGL ES (`dumpsys SurfaceFlinger | grep GLES`).
10. **Não publique nem copie para fora** o `getprop.txt` ou o número de série do aparelho.
11. **Seja honesto nas medições:** compare sempre no mesmo estado e não afirme ganhos que não mediu.

## Dicas técnicas

- Use `tr -d '\r'` na saída do `adb shell`. Algumas centrais devolvem `\r`.
- `uiautomator dump` pode fazer o app de configurações do fabricante fechar (bug de `PagedListView`). Evite nessas telas.
- Em algumas ROMs, `pm revoke` não tem efeito e bloqueios por `appops` voltam sozinhos.
- Se o aparelho sumir do `adb devices`, normalmente o USB mode voltou para host ou o carro desligou. Não fique tentando em loop: avise o usuário.
