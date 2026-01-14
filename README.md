Explicação das inclusões:

- `Properties`: Define a versão do Java e encoding para consistência.
- `Dependências`: Apenas JUnit 5 para testes – é leve e essencial para TDD (Test-Driven Development). Não adicionaria mais nada no início para manter simples.

- Plugins:
  - `maven-compiler-plugin`: Garante que o código compile com Java 21.
  - `maven-surefire-plugin`: Executa testes automaticamente com mvn test.

Scripts
```bash
make          # faz o ciclo completo
make run      # executa a aplicação
make test     # roda os testes
make clean    # limpa tudo
make help     # lista todos os comandos
```