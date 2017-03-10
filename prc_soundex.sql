SET TERM ^ ;

CREATE OR ALTER PROCEDURE VALORSOUNDEX (
    texto varchar(300))
returns (
    valor_soundex varchar(4))
as
declare variable letra_texto varchar(1);
declare variable codigo_soundex varchar(1);
declare variable i integer;
declare variable primeira_letra varchar(1);
declare variable texto_truncado varchar(4);
begin

  select substring(:texto from 1 for 1) from rdb$database into :primeira_letra;
  select substring(:texto from 2 for 999 ) from rdb$database into :texto;

  valor_soundex = upper(:primeira_letra);
  texto_truncado = '';

  /*****************************************************************************
  * Retira a primeira letra e as ocorrências de a, e, i, o, u, y, h, w do texto
  *****************************************************************************/
  i = 0;
  while (i < char_length(texto) ) do
  begin
      i = i+1;
      select substring(:texto from :i for 1) from rdb$database into :letra_texto;
      select tc.codigo from tab_caracteres tc where tc.caractere containing :letra_texto into :codigo_soundex;

      if ( (codigo_soundex != 0) ) then
      begin
        texto_truncado = :texto_truncado || :letra_texto;
      end
  end

  while (char_length(texto_truncado) < 4) do
  begin

    texto_truncado = :texto_truncado || 'A';

  end


  i = 1;
  while (i < (char_length(texto_truncado) +1))  do
  begin
    
    if (char_length(valor_soundex) = 4) then
    begin
      i = char_length(texto_truncado);
    end else
    begin

      select substring(:texto_truncado from :i for 1) from rdb$database into :letra_texto;
      select tc.codigo from tab_caracteres tc where tc.caractere containing :letra_texto into :codigo_soundex;
      valor_soundex = valor_soundex || codigo_soundex;

    end


    i = i+1;
  end

  suspend;
end^

SET TERM ; ^

GRANT SELECT ON TAB_CARACTERES TO PROCEDURE VALORSOUNDEX;

GRANT EXECUTE ON PROCEDURE VALORSOUNDEX TO SYSDBA;
