function r=controlling(NR,I)
% r = controlling(NR)
% ENTRADAS
%   - NR => son las caracter�sticas de las ventanas de todas la regiones
%   presentes en la im�gen.
% SALIDAS
%   - r => es un array que contendr� los �ndices de las ventanas que
%   encierran los caracteres de la matr�cula.

[rows, cols] = size(I);


% Calculamos una longitud de la y-height proporcional al Height de la
% im�gen. Por el tama�o de las imagenes con las que trabajamos los
% caracteres suelen ocupar en ellas entre un 18% y 80% de la Height de la
% im�gen. Seg�n la imagen que carguemos ajustaremos la busqueda de la moda
% para una y-height de caracter acorde al tama�o de la im�gen, de modo que
% la busqueda pueda utilizarse para im�genes grandes y peque�as (hasta
% cierto l�mite).
m = mode(NR( (NR(:,4) >= 0.18*rows) & (NR(:,4) <= 0.8*rows), 4 ));


p = 0.1*m; % Ajustamos la tolerancia a 0.1 pixeles por encima y por debajo de y-height
container = [m-p m+p];

% r es un array con los �ndices (rows) de los posibles caracteres encontrados en
% la im�gen
r = takeboxes(NR,container,2);

% En caso de que encontremos m�s de 7 caracteres, es que algo est� mal por
% lo que debemos de lanzar el mensaje de error al final. Para ello debemos
% darle el valor empty a r.
if length(r) > 7
    r = [];
end

end