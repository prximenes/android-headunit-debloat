# 5. Remover em lotes e desfazer

## O comando

```bash
adb shell pm uninstall -k --user 0 com.exemplo.pacote
```

- Remove o app **só do usuário 0** (o único da central).
- **Apps de sistema:** o APK continua na partição do sistema. Volta com:

  ```bash
  adb shell cmd package install-existing com.exemplo.pacote
  ```

- **Apps de terceiros:** o APK é apagado. Para voltar, reinstale pela loja ou pelo APK que você salvou no [backup](03-backup.md).
- Um **reset de fábrica** restaura todos os apps de sistema.

## Com o script

1. Crie um arquivo de lista (um pacote por linha, `#` para comentários). Veja [`lists/`](../lists/).
2. Rode:

   ```bash
   ./scripts/debloat.sh minha-lista.txt
   ```

   O script mostra os pacotes, pede confirmação, remove um por um e grava `backups/rollback_<data>.sh` com o comando para desfazer cada remoção que deu certo.

3. Para desfazer:

   ```bash
   ./scripts/restore.sh backups/rollback_<data>.sh
   ```

## Em lotes, testando entre eles

Remova de 5 a 15 pacotes por vez. Depois de cada lote, teste na central:

- [ ] Câmera de ré (engate a ré)
- [ ] Rádio
- [ ] Bluetooth: chamada e música
- [ ] Comandos do volante
- [ ] Android Auto/CarPlay
- [ ] Reiniciar a central e ver se volta normal

Se algo quebrou, desfaça o último lote inteiro e depois vá devolvendo pacote por pacote até achar o culpado.

## O que esperar

O ganho do debloat em si é **moderado**: apps parados quase não gastam nada. O ganho grande vem de achar os poucos processos que **ficam rodando o tempo todo**. Isso está no próximo passo.

Próximo: [6. Desempenho](06-desempenho.md)
