% #########################################################################
% Asignatura: Visi�n por computador
% Autor: Omar Su�rez L�pez
% Curso: 2015/2016
% Aplicaci�n: SISTEMA DE DETECCI�N DE MATR�CULAS
% #########################################################################
clear all; close all; clc;

%% TEST IMAGES
% Cargamos la im�gen de prueba
I1 = imread('test1a.jpg');


%% COMIENZO PROGRAMA
% Pasamos a escala de grises
I1 = rgb2gray(I1);

% Aplicamos Otsu e invertimos la im�gen para obtener las regiones con 1s
level = graythresh(I1);
bw = im2bw(I1,level);
bw = 1 - bw;

% Aplicamos un filtro de promediado para eliminar ruido
bw = medfilt2(bw,[3 3]);

% Etiquetamos las regiones
[Etiquetas, N] = bwlabel(bw);
MAP = [0 0 0; jet(N)];
I = ind2rgb(Etiquetas+1,MAP);
figure; imshow(I,MAP);
title('Etiquetas coloreadas');
impixelinfo

% Extraemos propiedades de todas las regiones
Iprops = regionprops(Etiquetas,'all');

NR = cat(1,Iprops.BoundingBox);

% Llamamos a la funci�n de control
r = controlling(NR,I1);


if ~isempty(r) % Si se detectan correctamente los caracteres...
    I={Iprops.Image}; % Cell array of 'Image' (one of the properties of regionprops)
    noPlate=[]; % Inicializamos el string donde guardaremos la matricula...
    for v=1:length(r)
        N=I{1,r(v)}; % Extraemos la im�gen binaria correspodiente al �ndice guardado en r...
        letter=readLetter(N,v); % Leemos el caracter correspondiente a la im�gen binaria 'N'
        while letter=='O' || letter=='0' % En caso de detectar 'O' o '0'... 
            if v<=4                      % durante la extracci�n de caracteres...
                letter='0';              % distinguiremos estos conociendo...
            else                         % que en las matr�culas espa�olas...
                letter='O';              % los 4 primeros caracteres son n�meros mientras.
            end                          % Usaremos esto para saber si estamos detectando uno u otro.
            break;                      
        end
        noPlate=[noPlate letter]; % Vamos guardando cada caracter detectado en el array
    end
    fid = fopen('noPlate.txt', 'wt'); % Escribimos la matricula detectada en un fichero de texto
    fprintf(fid,'%s\n',noPlate);    
    fclose(fid);                     
    winopen('noPlate.txt')
else % Si fallamos en la extracci�n y detecci�n sacamos un mensaje de error por pantalla
    fprintf('Unable to extract the characters from the number plate.\n');
end
