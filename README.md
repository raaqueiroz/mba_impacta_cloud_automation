<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<h1 align="center"> Módulo de provisionamento de VPC AWS + Servidor Jenkins </h1>

<p>
Módulo para provisionamento de infra de uma VPC na AWS com 4 subnets <br/><br/>
Sendo 2 Subnets privadas e 2 públicas em 2 AZs distintas, para permitir o MultiAZ tanto na "rede" privada como na pública. <br/>
É provisionado um internet gateway e atachada à VPC, e um NAT Gateway para permitir a saída de internet da subnet privada, 
provisionadas 2 tabelas de roteamento para ambas redes com as devidas rotas padrão de saída e associadas às respectivas subnets <br/>
Criado um novo Security Group para vinculo com a instancia EC2 e liberação de portas dos serviços
<br/><br/><br/>
Realizado o provisionamento de uma instancia EC2 na subnet pública, com IP elástico público. <br/>
Configurado user data para instalação do serviço do Jenkins nessa instancia.
Necessário possuir um par chaves SSH e disponibilizar a chave pública
</p>