clear all
close all
clc

%Variable tipo arduino para inicializar el dispositivo
a = arduino;

%Espacio para imprimir lo que leemos de la tarjeta 
figure
h = animatedline;
ax = gca;
ax.YGrid = 'on';

%Ciclo para adquirir 200 datos 
for x=1:200
    %Leemos el voltaje de la terminal analógica A0 de la tarjeta
    v = readVoltage(a,'A0');
    % Obtiene la hora de la computadora
    t =  datetime('now'); 
    % Agrega los puntos obtenidos a la gráfica
    addpoints(h,datenum(t),v);
    % Actualiza los datos en el eje x    
    datetick('x','keeplimits');
    xlabel('Tiempo (s)') 
    ax.YLim = [1 1.5];
    ylabel('Valor de corriente leído') 
    drawnow
end

[timeLogs,tempLogs] = getpoints(h);
M=mean(tempLogs)
