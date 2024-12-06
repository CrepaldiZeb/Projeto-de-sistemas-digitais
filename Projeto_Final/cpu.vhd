LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


entity cpu is
port( data: in std_logic_vector (7 downto 0); -- input do usuario
		w, clk,reset: in std_logic; -- w é start da maquina, e clock
		OPC : in std_logic_vector (5 downto 0); -- OPCODE carregando instruções e direções de reg
		done : out std_logic; -- sinal de conclusão da operação
		buss: inout std_logic_vector(7 downto 0)); -- barramento para a passagem de dados
	end cpu;
	
	architecture funca of cpu is 
	signal r0i, r0o, r1i, r1o, r2i, r2o, r3i, r3o, ain, gin, gout, ext, addsub : std_logic; -- aqui colocamos os sinais internos do circuito
	signal r0d,r1d,r2d,r3d, aout, resu, gresu : std_logic_vector(7 downto 0);
	
	component reg 
	PORT (  D : IN  STD_LOGIC_VECTOR(7 DOWNTO 0) ;
	enable, clk : IN  STD_LOGIC ;
	Q  : OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) ) ;
	END component;
	
	component ula
	PORT ( A, B				: in  	STD_LOGIC_VECTOR(7 DOWNTO 0);
	       add_sub       : in 		std_logic;
			 S					: out  	STD_LOGIC_VECTOR(7 DOWNTO 0));
	end component;
	
	component trist 
	 Port ( x    : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           e   : in  STD_LOGIC;                                        
           y    : out STD_LOGIC_VECTOR(7 DOWNTO 0));
	end component;
	
	component contu
	 Port ( OPC : in  STD_LOGIC_VECTOR(5 DOWNTO 0);
            w,clk,reset : in  STD_LOGIC;                                        
				done, ext, r0i, r0o, r1i, r1o, r2i, r2o, r3i, r3o,ain ,gin, gout ,addsub: out STD_LOGIC);
end component;

begin
reg0: reg port map(buss,r0i,clk,r0d);--
reg1: reg port map(buss,r1i,clk,r1d);-- CRIANDO OS 4 REGISTRADORES DE PROPOSITO GERAL
reg2: reg port map(buss,r2i,clk,r2d);--
reg3: reg port map(buss,r3i,clk,r3d);--

tri0: trist port map(r0d,r0o,buss);--
tri1: trist port map(r1d,r1o,buss);-- CRIANDO OS TRISTATE DOS REGISTRADORES DE PROPOSITO GERAL 
tri2: trist port map(r2d,r2o,buss);--
tri3: trist port map(r3d,r3o,buss);--

regA: reg port map(buss,ain,clk,aout);-- primeiro registrador auxiliar da ula
regG: reg port map(resu,gin,clk,gresu);-- segundo registrador auxiliar da ula
triG: trist port map(gresu,gout,buss);-- tristate que controla a saida da ULA para o BARRAMENTO

SOMA: ula port map(aout,buss,addsub,resu); -- declarando a ULA

CC: contu port map(OPC,w,clk,reset,done, ext, r0i, r0o, r1i, r1o, r2i, r2o, r3i, r3o, ain ,gin, gout , addsub); -- declaração da maquina de estados

triD: trist port map(data,ext,buss); -- TRISTATE QUE CONTROLA O CARREGAMENTONO NO BARRAMENTO

end funca;









