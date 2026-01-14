# ==============================================
# Makefile para projeto Java + Maven
# ==============================================

# Configurações básicas
APP_NAME := seu-projeto
JAR_FILE := target/$(APP_NAME)-*.jar
MAIN_CLASS := com.seuempresa.App   # ← Ajuste para sua classe principal

# Cores para output (opcional, mas fica bonito)
CYAN    := \033[0;36m
GREEN   := \033[0;32m
YELLOW  := \033[0;33m
RED     := \033[0;31m
NC      := \033[0m

.PHONY: all clean compile test run package install help

# Default target
all: clean compile test package

# ==============================================
# Comandos principais
# ==============================================

clean:                  ## Remove arquivos gerados (target/)
	@echo "$(CYAN)→ Limpando projeto...$(NC)"
	@mvn clean

compile:                ## Compila o projeto
	@echo "$(CYAN)→ Compilando...$(NC)"
	@mvn compile

test:                   ## Executa todos os testes
	@echo "$(CYAN)→ Executando testes...$(NC)"
	@mvn test

package:                ## Cria o .jar (mvn package)
	@echo "$(CYAN)→ Gerando pacote...$(NC)"
	@mvn package -DskipTests

install:                ## Instala no repositório local (~/.m2)
	@echo "$(CYAN)→ Instalando no repositório local...$(NC)"
	@mvn clean install

run: package            ## Compila + executa a aplicação (precisa ter main class)
	@echo "$(CYAN)→ Executando aplicação...$(NC)"
	@if [ -f $(JAR_FILE) ]; then \
		java -jar $(JAR_FILE); \
	else \
		echo "$(RED)Erro: JAR não encontrado! Execute 'make package' primeiro.$(NC)"; \
		exit 1; \
	fi

run-main: compile       ## Executa usando maven exec (mais flexível)
	@echo "$(CYAN)→ Executando classe principal com maven...$(NC)"
	@mvn exec:java -Dexec.mainClass="$(MAIN_CLASS)"

# ==============================================
# Comandos úteis adicionais
# ==============================================

deps:                   ## Mostra árvore de dependências
	@echo "$(CYAN)→ Árvore de dependências:$(NC)"
	@mvn dependency:tree -Dincludes=com.*

deps-tree: deps         ## Alias para mostrar árvore de dependências
	@:
update:                 ## Atualiza versões das dependências (cuidado!)
	@echo "$(YELLOW)→ Atualizando versões de dependências...$(NC)"
	@mvn versions:display-dependency-updates

clean-all: clean        ## Limpeza profunda (inclui .mvn, cache, etc)
	@echo "$(RED)→ Limpando tudo...$(NC)"
	@rm -rf target .mvn .DS_Store *.log

help:                   ## Mostra esta ajuda
	@echo ""
	@echo "Comandos disponíveis:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(GREEN)%-20s$(NC) %s\n", $$1, $$2}'
	@echo ""

# ==============================================
# Dicas rápidas
# ==============================================
# Uso comum:
#   make              → tudo (clean + compile + test + package)
#   make run          → compila e executa o jar
#   make test         → só testes
#   make clean package→ limpa e gera o jar
#   make help         → esta mensagem