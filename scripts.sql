create table tab_pessoa (
  nome varchar(100),
  sobrenome varchar(1000)
);

insert into tab_pessoa values ('Carlos', 'Brown');
insert into tab_pessoa values ('Carlos', 'Braun');
insert into tab_pessoa values ('Carlos', 'Broon');
insert into tab_pessoa values ('Carlos', 'Browne');
insert into tab_pessoa values ('Carlos', 'Braum');
insert into tab_pessoa values ('Carlos', 'Broom');
insert into tab_pessoa values ('Joao', 'Kennedy');
insert into tab_pessoa values ('Joao', 'Kennidi');
insert into tab_pessoa values ('Joao', 'Kenidy');
insert into tab_pessoa values ('Joao', 'Kenney');
insert into tab_pessoa values ('Joao', 'Kenidi');


create table tab_caracteres (
  codigo int, 
  caractere varchar(50)
);

-- As vogais A,E,I,O,U os caracteres Y,W e H e os demais demais caracteres n�o s�o considerados.
insert into tab_caracteres values (0, 'A, E, I, O, U, Y, W, H');
insert into tab_caracteres values (1, 'B, P, F, V');
insert into tab_caracteres values (2, 'C, S, G, J, K, Q, X, Z');
insert into tab_caracteres values (3, 'D, T');
insert into tab_caracteres values (4, 'L');
insert into tab_caracteres values (5, 'M,N');
insert into tab_caracteres values (6, 'R');
insert into tab_caracteres values (7, 'A, E, I, O, U, Y, W, H');

/***************************************************************************
 - Casos de testes Soundex
***************************************************************************/
select * from valorsoundex('soundex'); --S532
select * from valorsoundex('macoratti'); --M263
select * from valorsoundex('brown'); --B650
select * from valorsoundex('Rupert'); --R163
select * from valorsoundex('Robert'); --R163
select * from valorsoundex('Rubin'); --R150

/***************************************************************************
 - Casos de testes BuscaBR
***************************************************************************/
select * from buscabr('Wilson');--V
select * from buscabr('Vilson');--V
select * from buscabr('Uilson');--V
select * from buscabr('Show');--SW
select * from buscabr('Cowboy');--KWB
select * from buscabr('Walter');--VT
select * from buscabr('Valter');--VT
select * from buscabr('Feijão');--FJ
select * from buscabr('Feijaum');--FJ
select * from buscabr('Uruguai');--VRG
select * from buscabr('Fixar');--FS
select * from buscabr('Ficsar');--FS
select * from buscabr('Tórax');--TR
select * from buscabr('Tóracs');--TR
select * from buscabr('Emprego');--MPG
select * from buscabr('Imprego');--MPG
select * from buscabr('Habilitação');--BRTK
select * from buscabr('Abilitação');--BRTK
select * from buscabr('Gengibre');--JJB
select * from buscabr('Jengibre');--JJB


