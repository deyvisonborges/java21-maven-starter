#!/bin/bash

set -e  # Exit on error

# Instalar SDKMAN se não estiver instalado
if [ ! -d "$HOME/.sdkman" ]; then
    echo "Instalando SDKMAN..."
    curl -s "https://get.sdkman.io" | bash
fi

# Carregar SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Verificar se o comando sdk está disponível
if ! command -v sdk &> /dev/null; then
    echo "Erro: SDKMAN não foi carregado corretamente. Por favor, execute: source ~/.sdkman/bin/sdkman-init.sh"
    exit 1
fi

# Java version a instalar (tentará estas versões em ordem)
JAVA_VERSIONS=("21.0.1-tem" "21.0.2-tem" "21-tem")
JAVA_VERSION=""

# Verificar se Java 21 já está instalado
INSTALLED_JAVA=$(sdk list java | grep -E "(>>>|installed)" | grep "21.*tem" | head -1 | tr -s ' ' | cut -d' ' -f6 || echo "")

if [ -n "$INSTALLED_JAVA" ]; then
    echo "Java 21 (Temurin) já está instalado: $INSTALLED_JAVA"
    JAVA_VERSION="$INSTALLED_JAVA"
    sdk use java "$JAVA_VERSION"
else
    # Tentar instalar uma das versões disponíveis
    echo "Instalando Java 21 (Temurin)..."
    for version in "${JAVA_VERSIONS[@]}"; do
        echo "Tentando instalar Java $version..."
        if sdk install java "$version" <<< "Y" 2>/dev/null; then
            JAVA_VERSION="$version"
            echo "Java $JAVA_VERSION instalado com sucesso!"
            break
        fi
    done

    # Se nenhuma versão específica funcionou, tentar instalar qualquer versão 21-tem
    if [ -z "$JAVA_VERSION" ]; then
        echo "Tentando instalar a última versão Java 21 disponível..."
        # Usar sdk install com interação automática
        sdk install java 21-tem <<< "Y" || {
            echo "Erro: Não foi possível instalar Java 21 (Temurin)"
            echo "Por favor, instale manualmente com: sdk install java <versão>"
            exit 1
        }
        JAVA_VERSION="21-tem"
    fi
fi

# Garantir que estamos usando a versão instalada
if [ -z "$JAVA_VERSION" ]; then
    JAVA_VERSION=$(sdk current java 2>/dev/null || echo "21-tem")
fi

sdk use java "$JAVA_VERSION" 2>/dev/null || true

# Verificar instalação
echo ""
echo "Verificando instalação do Java:"
java -version

# Criar arquivo .sdkmanrc se não existir
if [ ! -f ".sdkmanrc" ]; then
    echo ""
    echo "Criando arquivo .sdkmanrc..."
    # Garantir que estamos usando a versão correta antes de criar o .sdkmanrc
    INSTALLED_JAVA=$(sdk list java | grep "installed" | grep "21.*tem" | head -1 | awk '{print $NF}' | xargs)
    if [ -z "$INSTALLED_JAVA" ]; then
        INSTALLED_JAVA="$JAVA_VERSION"
    fi
    sdk use java "$INSTALLED_JAVA"
    sdk env init
    echo "Arquivo .sdkmanrc criado com a versão Java instalada"
else
    echo "Arquivo .sdkmanrc já existe"
    # Aplicar as configurações do .sdkmanrc
    sdk env install
fi

echo ""
echo "Setup concluído com sucesso!"
echo "Para usar o Java deste projeto, execute: sdk env"
