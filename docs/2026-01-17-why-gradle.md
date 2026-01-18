# ADR #001: Adoção do Gradle como ferramenta de build para projetos JVM greenfield

**Data:** 17 de Dezembro de 2025  
**Status:** Aprovado  
**Autor:** [Seu Nome / Grok como arquiteto consultor]  
**Decisores:** Time de Arquitetura e Engenharia  
**Contexto:**  
Estamos iniciando um projeto greenfield em JVM (Java/Kotlin/Scala), com total liberdade para definir a stack de ferramentas. A escolha da ferramenta de build impacta diretamente a produtividade do time, a escalabilidade do projeto e a manutenção a longo prazo.

As duas opções principais no ecossistema JVM são:

- **Apache Maven** (padrão histórico, XML declarativo, amplamente adotado em empresas tradicionais)
- **Gradle** (mais moderno, scriptável com Kotlin/Groovy DSL, dominante em projetos novos e escaláveis como Android, Spring Boot, Netflix, etc.)

**Decisão:**  
Adotaremos o **Gradle** (com **Kotlin DSL**) como ferramenta de build padrão para todos os projetos greenfield JVM a partir de agora.

**Motivações principais (por que Gradle e não Maven):**

1. **Velocidade e performance**
   - Builds 2–10× mais rápidos em projetos médios/grandes graças ao daemon, builds incrementais, execução paralela e cache inteligente.
   - Menos tempo perdido esperando builds → maior produtividade e satisfação do time.

2. **Flexibilidade e extensibilidade**
   - Build como código (Kotlin DSL): permite lógica complexa, customizações e integração com Docker, frontend, CI/CD, testes de integração, etc., sem precisar criar plugins separados.
   - Maven é rígido e declarativo; Gradle permite adaptar o build às necessidades arquiteturais sem dor.

3. **Manutenção e escalabilidade em times**
   - Version catalogs centralizados → dependências em um único lugar (fácil atualizar versões em todo o monorepo).
   - Convention plugins → padronização automática de configurações entre módulos sem repetir código.
   - Suporte nativo a monorepos e multi-projetos (composite builds) — perfeito para microservices ou arquiteturas modulares.

4. **Alinhamento com o ecossistema moderno**
   - Gradle é a escolha oficial do Android, Spring Boot, Micronaut, Quarkus, GraalVM e grandes players (Netflix, LinkedIn, Google).
   - Maior atração de talentos jovens e alinhados com tendências atuais.

5. **Experiência do desenvolvedor (DX)**
   - Configurações concisas e legíveis (Kotlin DSL é tipado e seguro).
   - Build scans gratuitos → debug rápido de problemas de performance.
   - Menos "boilerplate XML" → menos frustração e erros de copy-paste.

**Consequências da decisão:**

- **Positivas**
  - Builds mais rápidos e confiáveis.
  - Configurações mais limpas e reutilizáveis.
  - Facilita adoção de práticas modernas (Kotlin Multiplatform, GraalVM native, etc.).
  - Time mais produtivo e motivado.

- **Negativas / Mitigações**
  - Curva de aprendizado inicial um pouco mais alta (especialmente Kotlin DSL) → **Mitigação:** workshops rápidos + templates prontos + documentação interna.
  - Risco de "script bagunçado" se o time não seguir boas práticas → **Mitigação:** adotar convention plugins e linting de build scripts.

**Opções consideradas (e por que foram descartadas):**

- **Maven**
  - Motivo de descarte: performance inferior, configuração verbosa, baixa flexibilidade para customizações complexas e desalinhamento com o ecossistema moderno.

- **Bazel**
  - Muito poderoso, mas overkill para a maioria dos projetos Java/Kotlin e curva de aprendizado alta demais para o time.

- **sbt (Scala)**
  - Excelente para Scala puro, mas menos adotado em projetos Java/Kotlin mistos.

**Referências:**

- Gradle vs Maven performance benchmarks: https://gradle.org/performance/
- Kotlin DSL guide: https://docs.gradle.org/current/userguide/kotlin_dsl.html
- Spring Boot + Gradle: https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#features.gradle
- Netflix build practices: https://netflixtechblog.com/optimizing-builds-with-gradle-etc.

**Próximos passos:**

- Criar template de projeto greenfield com Gradle + Kotlin DSL (versão mínima).
- Documentar conventions e plugins compartilhados no repositório de arquitetura.
- Realizar workshop de 1 hora para o time sobre Gradle + Kotlin DSL.
- Migrar projetos legados para Gradle apenas quando fizer sentido (não forçar retroativamente).

Assinaturas (para aprovação):

- [ ] Arquiteto Líder
- [ ] Líder Técnico
- [ ] Representante do Time de Engenharia
