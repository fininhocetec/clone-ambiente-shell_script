#!/usr/bin/env bash
#
# removerfeature - Remove completamente um ambiente apartir do nome do
#                    seu projeto.
#
#
# Finalidade do programa: Remover os containers, imagens, volumes, pasta do
#                         ambiente do projeto, ou seja, apagar todo o conteudo
#                         que faz parte do projeto da Feature em questão.
#
# Site:       https://www.wefor.com.br
# Autor:      Willdymark Ragazzi Ventura
# Manutenção: Willdymark Ragazzi Ventura "willdymark.venutura@wefor.com.br"
#
# ------------------------------------------------------------------------ #
#  Este programa irá remover todo conteúdo que faz parte do projeto/feature
#  criada para o ambiente em questão.
#  Exemplos:
# $ removerfeature "nome do ambinte"
#      Neste exemplo você deverá usar o argumento nome do projeto, ao qual
#      queira remover, exemplo "feature-relatorio".
#
#  OBSERVAÇÃO IMPORTANTE: NÃO TEM COMO REVERTER ESTE PROCESSO!!!
#                         CONFIRA SEMPRE O NOME DO PROJETO A SER REMOVIDO!!!
#                        DEVERÁ SER DIGITADO EXATAMENTE O NOME DO PROJETO".
#
# $ removerfeature feature-relatorio
#     argumento 1: "nome do projeto"
#   ou
# $ removerfeature feature-relatorio
#     argumento 1: "nome do projeto"
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 25/09/2020, willdymark:
#       - Início do programa
#   v1.1 09/10/2020, willdymark:
#       - Inclussão de verificação de pastas do sistema, para evitar que sejam
#         apagadas de forma indevida.
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.0.16
# ------------------------- VARIÁVEIS GLOBAIS ---------------------------- #
NOMEWILDFLY="wildfly-$1"
NOMEMETABASE="metabase-$1"
NOMEDIR="$1"
DIREXISTE="$HOME/reframax/$1"
HOME="$HOME/reframax/"
DIRSISTEMA=("dev" "backups" "base" "jenkins" "metabase" "mongodb" "deploy" "databases" "mysql" "reframax" "wildfly" "wildfly-files")
# ------------------------------- TESTES --------------------------------- #
#verificar se o argumento nome do projeto foi digitado;
[ $# -lt 1 ] && echo "Faltou passar o nome do Projeto a ser removido!!!" && exit 1

for ((i=0; i<${#DIRSISTEMA[@]}; i++)); do
  if [ "${DIRSISTEMA[$i]}" == "$1" ]; then
    echo "Este diretório perntece ao sistema e não poderá ser removido!!!"
    exit 1
  fi
done

[ ! -d "$DIREXISTE" ] && echo "Não existe um projeto com nome $1." && exit 1
# ------------------------ FUNÇÕES PRE EXECUÇÃO -------------------------- #
read -r -p "Você tem certeza? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
  cd $DIREXISTE
  docker-compose down --rmi all  -v
  cd
  echo "Digite abaixo a senha de SUDO para remover o diretório do projeto $1."
  sudo rm -r $DIREXISTE
  #
  echo "Ambiente $1 totalmente removido!!!"
else
    echo "Nada foi removido!!!"
    return
fi

# ------------------------------------------------------------------------ #
