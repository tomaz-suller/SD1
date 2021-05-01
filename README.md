# SD1

Repositório contendo as minhas resoluções para todos os trabalhos em VHDL propostos pela disciplina PCS3115 - Sistemas Digitais 1 da Poli-USP como ministrada no 2° semestre de 2020.

As pastas estão divididas em:
- `aulas`: Exemplos passados pelos professores em aula online sobre como fazer Máquinas de Estado Finitas (FSMs);
- `testes`: Testes aleatórios; em particular, alguns sobre operações utilizando o tipo `bit_vector`;
- `trabalho`: Resolução e testbench para cada um dos trabalhos passados pela disciplina, **sem** os seus respectivos enunciados. Os temas dos trabalhos são, respectivamente:
    1. Funções lógicas básicas usando o Digital;
    2. Conversor de código de Gray para binário, incluindo versão generalizada (usando o `generic` do VHDL);
    3. Mais funções lógicas básicas com o Digital e VHDL, dessa vez usando um script em Python para gerar casos de teste;
    4. Correção de erros com Código de Hamming (*versão generalizada, T4A3, não funciona*);
    5. Implementação de flip-flop e máquina de estados que reconhece padrões de entrada, usando tanto descrição estrutural (com FFs) quanto funcional (com `process`);
    6. Implementação de algoritmo para achar maior divisor comum (GCD) usando uma máquina de estados algorítmica (ASM);
    7. Implementação de registradores com várias funções para emprego em algoritmos de multiplicação e divisão de números decimais;
- `treino`: Tentativas aleatórias de implementar componentes vistos em aula, abandonadas antes que funcionassem.

Exceto pela T4A3, todas as resoluções de trabalho funcionam e passam nos testes de seus respectivos testbenches.

O objetivo deste repositório é servir de exemplo para a implementação de sistemas digitais usando VHDL, e não fornecer soluções prontas para os trabalhos propostos, por isso enunciados não foram incluídos. Outro motivo para isso é que os enunciados são propriedade dos professores que os criaram, então não posso compartilhá-los sem devida permissão.

Sinta-se à vontade para contribuir com soluções a trabalhos de outros períodos. Caso queira, *depois que o semestre letivo acabar*, faça uma PR para o repositório que eu integro suas soluções para ter uma base maior de referências.