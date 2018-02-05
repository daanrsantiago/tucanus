function resultado = graficoZ(x,y)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

[X Y] = meshgrid(x,y);
Z = -(X.^2)./4-(Y.^2)./4;
resultado = mesh(X,Y,Z);
end

