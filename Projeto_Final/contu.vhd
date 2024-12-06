-- Antonio Crepaldi 21012485
-- Carlos Eduardo 21003900
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contu is
    Port ( OPC : in  STD_LOGIC_VECTOR(5 DOWNTO 0);
           w,clk,reset : in  STD_LOGIC;                                        
           
			done, ext, r0i, r0o, r1i, r1o, r2i, r2o, r3i, r3o,ain ,gin, gout ,addsub: out STD_LOGIC);
end contu;

architecture funca of contu is 


TYPE estado IS (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9);
SIGNAL ea, pe : estado ;  -- estado atual e prox estado

begin

	PROCESS ( reset, clk, OPC, w)
	
begin

	case ea is 
			when s0 =>
			
				r0i <= '0';
				r0o <= '0';
				r1i <= '0';
				r1o <= '0';
				r2i <= '0';
				r2o <= '0';					--quando está em s0 essa parte do codigo serve para 
				r3i <= '0';
				r3o <= '0';
				ain <= '0';
				gin <= '0';
				gout <= '0';
				addsub <='0';
				ext <= '0';
				done <= '0';
		
		if w = '0' then
		pe <= s0; 	-- MAQUINA NÃo INICIA w=0
		else 
		pe <= s1; -- DA O START NA MAQUINA
		
		end if;
		
			when s1 =>  -- ESTAGIO COMUM PARA RECEBER Os primeiros digitos do OPCODE
			
				if (OPC(5) = '0' and OPC(4) = '0') then -- LOAD CODIGO 00 do opcode
				pe <= s2; --s2 é onde faremos o load 
				
				elsif (OPC(5) = '0' and OPC(4) = '1') then -- MOV CODIGO 01 do opcode
				pe <= s3; --s3 é onde faremos o MOV
				
				elsif (OPC(5) = '1' and OPC(4) = '0') then -- ADD CODIGO 10 do opcode
				pe <= s4; --s4 é onde faremos o ADD precisaremos de 3 tempos de clock
				
				else -- SUB CODIGO 11 do opcode
				pe <= s7; --s7 é onde faremos o SUB e também precisaremos de 3 tempos de clock
				
			end if;
			
			when s2 => -- estamos no processo do load
			
			-- AGORA PRECISAMOS VER QUAL O REGISTRADOR Q RECEBERÁ do DATA. ESSA INFO ESTÁ PRESENTE 
			--NO BIT 2 e 3 DO OPC
			
			if (OPC(3) = '0' and OPC(2) = '0') then -- REGISTRADOR RX = 00 
			
				r0i <= '1'; --apenas a porta do r0 está aberta, pois ele está selecionado
				r0o <= '0';
				r1i <= '0';
				r1o <= '0';
				r2i <= '0';
				r2o <= '0';					
				r3i <= '0';
				r3o <= '0';
				ext <= '1'; -- extern está selecionado para abrir o data para o BUS
				done <= '1'; -- done fala q o processo acabou 
			
			elsif (OPC(3) = '0' and OPC(2) = '1') then -- REGISTRADOR RX = 01 
			
				r0i <= '0'; 
				r0o <= '0';
				r1i <= '1';--apenas a porta do r1 está aberta, pois ele está selecionado
				r1o <= '0';
				r2i <= '0';
				r2o <= '0';					
				r3i <= '0';
				r3o <= '0';
				ext <= '1'; -- extern está selecionado para abrir o data para o BUS
				done <= '1'; -- done fala q o processo acabou 
			
			elsif (OPC(3) = '1' and OPC(2) = '0') then -- REGISTRADOR RX = 10 
			
				r0i <= '0'; 
				r0o <= '0';
				r1i <= '0';
				r1o <= '0';
				r2i <= '1';--apenas a porta do r2 está aberta, pois ele está selecionado
				r2o <= '0';					
				r3i <= '0';
				r3o <= '0';
				ext <= '1'; -- extern está selecionado para abrir o data para o BUS
				done <= '1'; -- done fala q o processo acabou 
				
				
			else  -- REGISTRADOR RX = 11 
			
				r0i <= '0'; 
				r0o <= '0';
				r1i <= '0';
				r1o <= '0';
				r2i <= '0';
				r2o <= '0';					
				r3i <= '1';	--apenas a porta do r3 está aberta, pois ele está selecionado
				r3o <= '0';
				ext <= '1'; -- extern está selecionado para abrir o data para o BUS
				done <= '1'; -- done fala q o processo acabou 
				
			end if;
			
		pe <= s0; 
		
		when s3 => --AQUI é NO MOV
		
				if (OPC(3) = '0' and OPC(2) = '0') then -- rx = 00 receberá o conteudo de ry
				
				r0i <= '1'; -- abrindo as entradas de r0
				
				elsif (OPC(3) = '0' and OPC(2) = '1') then -- rx = 01 receberá o conteudo de ry
				
				r1i <= '1'; -- abrindo as entradas de r1
				
				elsif (OPC(3) = '1' and OPC(2) = '0') then -- rx = 10 receberá o conteudo de ry
				
				r2i <= '1'; -- abrindo as entradas de r2
				
				else 											 -- rx = 11 receberá o conteudo de ry
				
				r3i <= '1'; -- abrindo as entradas de r3
			
			end if;
				
				if (OPC(1) = '0' and OPC(0) = '0') then -- ry = 00 doará o seu conteudo para rx
				
				r0o <= '1'; -- abrindo as saídas de r0
				
				elsif (OPC(1) = '0' and OPC(0) = '1') then -- ry = 01 doará o seu conteudo para rx
				
				r1o <= '1'; -- abrindo as saídas de r1
				
				elsif (OPC(1) = '1' and OPC(0) = '0') then -- ry = 10 doará o seu conteudo para rx
				
				r2o <= '1'; -- abrindo as saídas de r2
				
				else  -- ry = 11 doará o seu conteudo para rx
				
				r3o <= '1'; -- abrindo as saídas de r3
				
			end if;
			
			done <= '1';	
				pe <= s0;
	when s4 => -- ESTAMOS NA SOMAAAAAAAA BORA // primeira etapa step1: localizar o rx e dar sinal pro registrador da soma
	
		if (OPC(3) = '0' and OPC(2) = '0') then	--Aqui a gente proucura RX primeiro em 00
		r0o <= '1';
		
		elsif (OPC(3) = '0' and OPC(2) = '1') then	--agora em 01
		r1o <= '1';
		
		elsif (OPC(3) = '1' and OPC(2) = '0') then	-- depois em  10
		r2o <= '1';
		
		else 	-- E finalmente em 11
		r3o <= '1';	
		
		end if;
		Ain <= '1';
		
		pe <= s5;
		
		when s5 => -- SEGUNDA ETAPAAAA DA ADIÇÃO ESTAMOS NO T2
					  -- BORA LIBERAR ACHAR E LIBERAR RY, DAR O SINAL DE SOMA E GIN
		
		if (OPC(1) = '0' and OPC(0) = '0') then	--Aqui a gente proucura Ry primeiro em 00
		r0o <= '1';
		
		elsif (OPC(1) = '0' and OPC(0) = '1') then	--agora em 01
		r1o <= '1';
		
		elsif (OPC(1) = '1' and OPC(0) = '0') then	-- depois em  10
		r2o <= '1';
		
		else 	-- E finalmente em 11
		r3o <= '1';
		
		end if;
		
		addsub <= '0'; -- sinal de adição cara
		gin <= '1'; -- sinal pro reg
		
		pe <= s6; -- bora pro step final 
		
		when s6 => -- estamos na final, hoje tem hexa ! tempo 3 alias
					  -- Gout rxin e done	
		gout <= '1';
		
			if (OPC(3) = '0' and OPC(2) = '0') then	--Aqui a gente proucura RX primeiro em 00
			r0i <= '1';
			
			elsif (OPC(3) = '0' and OPC(2) = '1') then	--agora em 01
			r1i <= '1';
			
			elsif (OPC(3) = '1' and OPC(2) = '0') then	-- depois em  10
			r2i <= '1';
			
			else 	-- E finalmente em 11
			r3i <= '1';	
			
			end if;
			
			done <= '1'; -- finalmente, todo o processo da soma acabou e familias agora são felizes
			
			pe <= s0;
			
		when s7 => -- ESTAMOS NA SUB BORA // primeira etapa step1: localizar o rx e dar sinal pro registrador da sub
	
		if (OPC(3) = '0' and OPC(2) = '0') 	then --Aqui a gente proucura RX primeiro em 00
		r0o <= '1';
		
		elsif (OPC(3) = '0' and OPC(2) = '1') 	then --agora em 01
		r1o <= '1';
		
		elsif (OPC(3) = '1' and OPC(2) = '0') then	-- depois em  10
		r2o <= '1';
		
		else 	-- E finalmente em 11
		r3o <= '1';	
		
		end if;
		Ain <= '1';
		
		pe <= s8;
		
		when s8 => -- SEGUNDA ETAPAAAA DA sub ESTAMOS NO T2
					  -- BORA LIBERAR ACHAR E LIBERAR RY, DAR O SINAL DE sub E GIN
		
		if (OPC(1) = '0' and OPC(0) = '0') then	--Aqui a gente proucura Ry primeiro em 00
		r0o <= '1';
		
		elsif (OPC(1) = '0' and OPC(0) = '1') then	--agora em 01
		r1o <= '1';
		
		elsif (OPC(1) = '1' and OPC(0) = '0') then	-- depois em  10
		r2o <= '1';
		
		else 	-- E finalmente em 11
		r3o <= '1';
		
		end if;
		
		addsub <= '1'; -- sinal de sub cara
		gin <= '1'; -- sinal pro reg
		
		pe <= s9; -- bora pro step final 
		
		when s9 => -- estamos na final, hoje tem hexa ! tempo 3 alias
					  -- Gout rxin e done	
		gout <= '1';
		
			if (OPC(3) = '0' and OPC(2) = '0') then	--Aqui a gente proucura RX primeiro em 00
			r0i <= '1';
			
			elsif (OPC(3) = '0' and OPC(2) = '1') 	then --agora em 01
			r1i <= '1';
			
			elsif (OPC(3) = '1' and OPC(2) = '0') then	-- depois em  10
			r2i <= '1';
			
			else 	-- E finalmente em 11
			r3i <= '1';	
			
			end if;
			
			done <= '1'; -- finalmente, todo o processo da sub acabou e familias agora são mais felizes
			
			pe <= s0;
			
			 end case;
			 
			 end process;
			 
			 process(clk)
				begin
				
				IF clk 'EVENT AND clk = '1' THEN
				
				ea <= pe; -- para passar o clock
				end if;
			 
		end process;
		
		
end funca;