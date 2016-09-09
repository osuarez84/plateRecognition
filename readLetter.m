function letter=readLetter(snap,v)
% letter = readLetter(snap,v)
% ENTRADAS
%   - snap => es la imagen del caracter detectado
%   - v => es la imágen sobre la que estamos detectando
% SALIDAS
%   - letter => caracter alfanumérico detectado

load NewTemplatesOMAR % Cargamos los templates de los caracteres alfanuméricos

snap=imresize(snap,[42 24]); % Hacemos un resize a la imágen del caracter obtenido
comp=[];


% Los 4 primeros caracteres sabemos que siempre van a ser números, así que
% solo comprobamos números cuando v < 5. En caso contrario comprobamos
% letras.
if v >= 5
    NewTemplates_aux = NewTemplates(1,1:33);
else
    NewTemplates_aux = NewTemplates(1,34:50);
end


for n=1:length(NewTemplates_aux)
    sem=corr2(NewTemplates_aux{1,n},snap); % Calculamos la correlación entre la imágen de entrada y cada uno de los templates
    comp=[comp sem]; % Guardamos todos los valores de correlación 
    
end
vd=find(comp==max(comp)); % Buscamos el máximo valor de todos y su índice

% En caso de que haya varios maximos seleccionamos el primero
vd = vd(1);

%*-*-*-*-*-*-*-*-*-*-*-*-*-
% Índices asignados a cada template en NewTemplatesOMAR
% Los 4 primeros caracteres sabemos que siempre van a ser números, así que
% solo comprobamos números cuando v < 5. En caso contrario comprobamos
% letras.
if v >= 5
    if vd==1 || vd==2
        letter='A';
    elseif vd==3 || vd==4
        letter='B';
    elseif vd==5
        letter='C';
    elseif vd==6 || vd==7
        letter='D';
    elseif vd==8
        letter='E';
    elseif vd==9
        letter='F';
    elseif vd==10
        letter='G';
    elseif vd==11
        letter='H';
    elseif vd==12
        letter='I';
    elseif vd==13
        letter='J';
    elseif vd==14
        letter='K';
    elseif vd==15
        letter='L';
    elseif vd==16
        letter='M';
    elseif vd==17
        letter='N';
    elseif vd==18 || vd==19
        letter='O';
    elseif vd==20 || vd==21
        letter='P';
    elseif vd==22 || vd==23
        letter='Q';
    elseif vd==24 || vd==25
        letter='R';
    elseif vd==26
        letter='S';
    elseif vd==27
        letter='T';
    elseif vd==28
        letter='U';
    elseif vd==29
        letter='V';
    elseif vd==30
        letter='W';
    elseif vd==31
        letter='X';
    elseif vd==32
        letter='Y';
    elseif vd==33
        letter='Z';
    end
    
else
    %*-*-*-*-*
    % Numerales
    if vd==1
        letter='1';
    elseif vd==2
        letter='2';
    elseif vd==3
        letter='3';
    elseif vd==4 || vd==5
        letter='4';
    elseif vd==6
        letter='5';
    elseif vd==7 || vd==8 || vd==9
        letter='6';
    elseif vd==10
        letter='7';
    elseif vd==11 || vd==12
        letter='8';
    elseif vd==13 || vd==14 || vd==15
        letter='9';
    elseif vd==16 || vd==17
        letter='0';
    end
end
end