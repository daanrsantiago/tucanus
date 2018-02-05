function   index = buscam(sm,busca);
% algoritmo que le o input e retorna o index da celula em que possui o
% input 
for n=1:length(sm)
  m = string(sm{n});
  araymond(n) = m;
  m = 0;
end
for n=1:length(sm)
    if (busca==araymond(n))
        index = n;
    end
end
end