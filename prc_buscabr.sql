CREATE PROCEDURE BUSCABR (
    texto varchar(1000))
returns (
    codigobr varchar(1000))
as
declare variable texto_sem_primeira_letra varchar(1000);
declare variable primeira_letra char(1);
declare variable ultima_letra char(1);
declare variable texto_tratado varchar(1000);
declare variable texto_limpo varchar(1000);
declare variable i integer;
begin

  /***************************************************************************
  * Tutoriais base
  * http://clubedosgeeks.com.br/artigos/busca-fonetica-com-javascript-e-buscabr
  * http://www.linhadecodigo.com.br/artigo/2237/implementando-algoritmo-buscabr.aspx
  ***************************************************************************/

  /****************************************************************************
  * - Retira os caracteres especiais e converte todas as letras para maiúsculo
  ****************************************************************************/
   select upper(retorno) from elimina_especiais(:texto) into :TEXTO_LIMPO;

  --Substituimos Y por I;
  texto_tratado = replace(:texto_limpo, 'Y', 'I');


  -- Substituimos W ou U por V
  select substring(:TEXTO_TRATADO from 1 for 1) from rdb$database into :PRIMEIRA_LETRA;
  if (PRIMEIRA_LETRA = 'W' or (primeira_letra = 'U') ) then
  begin
    select substring(:TEXTO_TRATADO from 2 for char_length(:texto_tratado)) from rdb$database into :TEXTO_TRATADO;
    texto_tratado = 'V' || texto_tratado;
  end



  -- Substituimos BR, BL por B;
  texto_tratado = replace(:texto_tratado, 'BR', 'B');
  texto_tratado = replace(:texto_tratado, 'BL', 'B');
  --Substituimos PH por F;
  texto_tratado = replace(:TEXTO_TRATADO, 'PH', 'F');
  --Substituimos L por R
  texto_tratado = replace(:TEXTO_TRATADO, 'L', 'R');
  --  Substituimos GL, GR, MG, NG, RG por G;
  texto_tratado = replace(:TEXTO_TRATADO, 'GL', 'G');
  texto_tratado = replace(:TEXTO_TRATADO, 'GR', 'G');
  texto_tratado = replace(:TEXTO_TRATADO, 'MG', 'G');
  texto_tratado = replace(:TEXTO_TRATADO, 'NG', 'G');
  texto_tratado = replace(:TEXTO_TRATADO, 'RG', 'G');
  --Substituimos GE, GI, RJ, MJ, NJ por J;
  texto_tratado = replace(:TEXTO_TRATADO, 'GE', 'J');
  texto_tratado = replace(:TEXTO_TRATADO, 'GI', 'J');
  texto_tratado = replace(:TEXTO_TRATADO, 'RJ', 'J');
  texto_tratado = replace(:TEXTO_TRATADO, 'MJ', 'J');
  texto_tratado = replace(:TEXTO_TRATADO, 'NJ', 'J');
  --SubstituimosCE, CI, CH, CS, RS, TS, X, Z por S;
  texto_tratado = replace(:TEXTO_TRATADO, 'CE', 'S');
  texto_tratado = replace(:TEXTO_TRATADO, 'CI', 'S');
  texto_tratado = replace(:TEXTO_TRATADO, 'CH', 'S');
  texto_tratado = replace(:TEXTO_TRATADO, 'CS', 'S');
  texto_tratado = replace(:TEXTO_TRATADO, 'RS', 'S');
  texto_tratado = replace(:TEXTO_TRATADO, 'TS', 'S');
  texto_tratado = replace(:TEXTO_TRATADO, 'X', 'S');
  texto_tratado = replace(:TEXTO_TRATADO, 'Z', 'S');
  --Substituimos CT, RT,ST,PT por T;
  texto_tratado = replace(:TEXTO_TRATADO, 'CT', 'T');
  texto_tratado = replace(:TEXTO_TRATADO, 'RT', 'T');
  texto_tratado = replace(:TEXTO_TRATADO, 'ST', 'T');
  texto_tratado = replace(:TEXTO_TRATADO, 'PT', 'T');
  --Substituimos Q, CA, CO, CU, C por K;
  texto_tratado = replace(:TEXTO_TRATADO, 'Q', 'K');
  texto_tratado = replace(:TEXTO_TRATADO, 'CA', 'K');
  texto_tratado = replace(:TEXTO_TRATADO, 'CO', 'K');
  texto_tratado = replace(:TEXTO_TRATADO, 'CU', 'K');
  texto_tratado = replace(:TEXTO_TRATADO, 'CK', 'K');
  texto_tratado = replace(:TEXTO_TRATADO, 'C', 'K');
  --Substituimos LH por L;
  texto_tratado = replace(:TEXTO_TRATADO, 'LH', 'L');
  --Substituimos N, AO, AUM, GM, MD, OM, ON por M
  texto_tratado = replace(:TEXTO_TRATADO, 'N', 'M');
  texto_tratado = replace(:TEXTO_TRATADO, 'AO', 'M');
  texto_tratado = replace(:TEXTO_TRATADO, 'AUM', 'M');
  texto_tratado = replace(:TEXTO_TRATADO, 'GM', 'M');
  texto_tratado = replace(:TEXTO_TRATADO, 'MD', 'M');
  texto_tratado = replace(:TEXTO_TRATADO, 'OM', 'M');
  texto_tratado = replace(:TEXTO_TRATADO, 'ON', 'M');
  --Substituimos PR por P
  texto_tratado = replace(:TEXTO_TRATADO, 'PR', 'P');

  --Remove vogais (A,E,I,O,U) e H
  texto_tratado = replace(:TEXTO_TRATADO, 'A', '');
  texto_tratado = replace(:TEXTO_TRATADO, 'E', '');
  texto_tratado = replace(:TEXTO_TRATADO, 'I', '');
  texto_tratado = replace(:TEXTO_TRATADO, 'O', '');
  texto_tratado = replace(:TEXTO_TRATADO, 'H', '');
  texto_tratado = replace(:TEXTO_TRATADO, 'U', '');



    --Elimina terminações em S, Z, R, M, N, AO e L
    select substring(:TEXTO_TRATADO from char_length(:texto_tratado) for 1) from rdb$database into :ultima_letra;
  
    while (
      (ultima_letra = 'S') or
      (ultima_letra = 'Z') or
      (ultima_letra = 'R') or
      (ultima_letra = 'M') or
      (ultima_letra = 'N') or
      (ultima_letra = 'AO') or
      (ultima_letra = 'L')
    ) do
    begin
      if (char_length(:texto_tratado) < 3) then
      begin
        break;
      end

      select substring(:TEXTO_TRATADO from 1 for character_length(:TEXTO_TRATADO) -1) from rdb$database into :TEXTO_TRATADO;
      select substring(:TEXTO_TRATADO from char_length(:texto_tratado) for 1) from rdb$database into :ultima_letra;
    end







  codigobr = TEXTO_TRATADO;


  suspend;end
