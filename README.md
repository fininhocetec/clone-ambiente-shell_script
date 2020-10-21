![shell-script](https://img.shields.io/badge/shell-script-red?style=flat-square)
![docker](https://img.shields.io/badge/docker-19.03.12-green?style=flat-square)
![docker-compose](https://img.shields.io/badge/docker--compose-----compatibility-orange?style=flat-square?style=flat-square)
![wildfly](https://img.shields.io/badge/wildfly-10-yellow?style=flat-square)
![metabase](https://img.shields.io/badge/metabase-7--v0.34.0-lightgrey?style=flat-square)

Clonar e Remover Ambiente de Feature
========================

![Capa](capa.png "Capa")

## Adicionar ou remover um ambiente para utilizar novas Features

cloneambiente.sh - Faz o clone do ambiente de base, renomeando para um nome escolhido e, renomeando todos os objetos e alterando as portas dos serviços.

 Finalidade do programa: Criar um ambiente para o desenvolvedor testar novas funcionalidades "features" e rodar em um ambiente que não apalhe o ambientes de develop/homologação.
                         Ex.: Uma nova branch feature-botao.

removerfeature.sh - Remove completamente um ambiente apartir do nome do
                    seu projeto.

 Finalidade do programa: Remover os containers, imagens, volumes, pasta  o ambiente do projeto, ou seja, apagar todo o conteudo que faz parte do projeto da Feature em questão.

Requisitos
------------

- Docker (incluindo docker-compose)
- Diretório Base para ser duplicado e renomeado
- Ambiente de develop and homolog completo (MySQL, Wildfly, MongoDB, Nexus, GitLab, Jenkins, Metabase e Traefik)


Dependências
------------

Linux Bash.

Execução
-------------------

Para criar um novo ambiente de Feature:  

    $ cloneambiente "nome do projeto"

Para remover um ambiente de Feature:

    $ removerfeature "nome do ambinte"



Informações do Autor
------------------

- Este projeto foi criado por Willdimark Ragazzi Ventura, DevOps Engineer. (<fininho.cetec@gmail.com>)
- Linkedin [Perfil](https://www.linkedin.com/in/willdymark-ragazzi-ventura-ccna-devnetsecops-membro-anppd%C2%AE-a4422617//).
