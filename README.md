# java21-maven-starter

Um projeto base (boilerplate/starter) minimalista e moderno em **Java 21** usando apenas **Maven** (sem Spring ou frameworks pesados).

Perfeito para começar projetos novos rapidamente, protótipos, bibliotecas, ferramentas CLI, ou quando você quer uma estrutura limpa e atualizada.

### O que já vem configurado:
- Java 21 (LTS mais recente)
- Maven 3.9+ compatível
- Compilação com maven-compiler-plugin
- Testes com JUnit 5 (Jupiter)
- Plugin Surefire para execução de testes
- Encoding UTF-8 por padrão
- Makefile com comandos úteis: clean, compile, test, package, run, help...
- Estrutura padrão Maven + classe principal de exemplo
- .gitignore bem configurado

### Como usar
1. Clone o repositório
2. Renomeie o groupId/artifactId no pom.xml e no pacote das classes
3. Comece a codar! 🚀

```bash
make          # clean + compile + test + package
make run      # executa a aplicação
make test     # roda os testes
make help     # lista todos os comandos
```

Explicação das inclusões:

- `Properties`: Define a versão do Java e encoding para consistência.
- `Dependências`: Apenas JUnit 5 para testes – é leve e essencial para TDD (Test-Driven Development). Não adicionaria mais nada no início para manter simples.

- Plugins:
  - `maven-compiler-plugin`: Garante que o código compile com Java 21.
  - `maven-surefire-plugin`: Executa testes automaticamente com mvn test.
