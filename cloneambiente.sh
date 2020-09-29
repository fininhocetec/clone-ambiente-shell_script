#!/usr/bin/env bash
#
# cloneambiente.sh - Faz o clone do ambiente de base, renomeando
#                    para um nome escolhido e, renomeando todos os objetos e
#                    alterando as portas dos serviços.
#
# Finalidade do programa: Criar um ambiente para o desenvolvedor testar novas
#                         funcionalidades "features" e rodar em um ambiente
#                         que não atrapalhe o ambientes de develop/homologação.
#                         Ex.: Uma nova branch feature-botao.
#
# Site:       https://www.wefor.com.br
# Autor:      Willdymark Ragazzi Ventura
# Manutenção: Willdymark Ragazzi Ventura "willdymark.venutura@wefor.com.br"
#
# ------------------------------------------------------------------------ #
#  Este programa irá efetuar o clone do ambiente de base e, irá
#  renomear também todos os objetos e alterando as portas dos serviços.
#  Exemplos:
# $ sh cloneambiente.sh "nome do ambinte"
#      Neste exemplo você deverá usar o argumento nome do projeto, onde
#      ficara o nome do ambiente, exemplo "feature-relatorio".
#
#  OBSERVAÇÃO IMPORTANTE: NÃO DÊ NOMES AO PORJETO COM LETRAS MAIUSCULAS!!!
#                         Procure nomear seus projetos com base no nome da
#                        feature a ser usada ex:"feature-botao".
#
# $ sh cloneambiente.sh feature-relatorio
#     argumento 1: "nome do projeto"
#   ou
# $ source cloneambiente.sh feature-relatorio
#     argumento 1: "nome do projeto"
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 25/09/2020, willdymark:
#       - Início do programa
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.0.16
# ------------------------- VARIÁVEIS GLOBAIS ---------------------------- #
NOMEDIR="$1"
DIREXISTE="$HOME/pasta_projeto/$1"
# ------------------------------- TESTES --------------------------------- #
#verificar se o argumento nome do projeto foi digitado;
[ $# -lt 1 ] && echo "Faltou passar o nome do Projeto a ser criado!!!" && return
[ -d "$DIREXISTE" ] && echo "Já existe um projeto com este nome." && return
# ------------------------ FUNÇÕES PRE EXECUÇÃO -------------------------- #
#Achar a ultima porta livre para o wildfly;
UltimaPortaWildflyLivre () {
starting_port=8080
ending_port=8989
  for i in $(seq $starting_port $ending_port); do
      if ! [[ $(netstat -lnt | grep ":$i") ]]; then
        port_to_use_wildfly=$i
        break
      fi
  done
}
#Achar a ultima porta livre para o metabase;
UltimaPortaMetabaseLivre () {
starting_port=3000
ending_port=3199
  for i in $(seq $starting_port $ending_port); do
      if ! [[ $(netstat -lnt | grep ":$i") ]]; then
        port_to_use_metabase=$i
        break
      fi
  done
}
UltimaPortaWildflyLivre
UltimaPortaMetabaseLivre
#------------------------ FUNÇÕES PRE EXECUÇÃO -------------------------- #
#se o nome do projeto não existir a pasta será criada com o nome inserido.
mkdir $HOME/pasta_projeto/$1
echo "Criando a pasta do projeto $1 e copiando a base, este processo poderá demorar...."
#copiando a pasta base para a pasta do projeto criado.
cp -r $HOME/pasta_projeto/base/* $HOME/pasta_projeto/$1/
# ------------------------------- EXECUÇÃO ------------------------------- #
#renomeando o conteúdo dos arquivos docker-compose e standalone.xml.
echo "Subistituindo parte dos arquivos do projeto $1."
substituir=( "project" "PORTAWILDFLY" "PORTAMETABASE" )
substituto=( "$1" "$port_to_use_wildfly" "$port_to_use_metabase" )

for ((i=0; i<${#substituir[@]}; ++i)); do
    printf "Substituindo ${substituir[i]} por ${substituto[i]}...\n"

    sed -i "s/${substituir[i]}/${substituto[i]}/" $HOME/pasta_projeto/$1/docker-compose.yaml
done

substituir=( "project" )
substituto=( "$1" )

for ((i=0; i<${#substituir[@]}; ++i)); do
    printf "Substituindo ${substituir[i]} por ${substituto[i]}...\n"

    sed -i "s/${substituir[i]}/${substituto[i]}/" $HOME/pasta_projeto/$1/wildfly/standalone.xml
done

# ------------------------ FUNÇÕES POS EXECUÇÃO -------------------------- #
#subindo o ambiente.
cd $HOME/pasta_projeto/$1
echo "Subindo os contatiners do Wildfly e Metabase pelo docker-compose........."
docker-compose --compatibility up -d
clear
docker container ls -n 2
cd
echo "Ambiente pronto!!!"
echo "Não esqueça de alterar para $1 o TenantConfig.xml ao compilar!!!"
echo "Acesse pelo endereço https://$1.dev.dominio_empresa.com.br"
# ------------------------------------------------------------------------ #
