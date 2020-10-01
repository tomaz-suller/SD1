
count = 0
binary = [0, 1]

atividade = 3

for i in binary:
    for j in binary:
        for k in binary:
            b_value = str(i)+str(j)+str(k)
            p_value = int( (i+j+k) >= 2 ) 
            print(f'sensores <= "{b_value}";')
            print('wait for 1 ns;')
            print(f'assert porta = \'{p_value}\' report "Teste {count} falhou!" severity warning;')
            if atividade == 3:
                led = int( not (i == j == k) )
                print(f'assert light = \'{led}\' report "Teste {count} LED falhou!" severity warning;')
            print('')
            count += 1