clear all
close all
clc

%Valores de temperatura usados para calibrar
e=[11 20 22 24 26 28 30 32 34 36 38 40 67]';
%Promedio de valores del ADC leídos
T=[1.2576 1.4498 1.4849 1.5299 1.5706 1.6096 1.6583 1.6980 1.7414 1.7814 1.8209 1.8670 2.3862]';
 
Ajuste_lineal = fit(T,e,'poly2')
plot(T,e,'o');
plot(Ajuste_lineal,T,e);

%Creamos una variable tipo arduino para inicializar el dispositivo
a = arduino;
%Leemos el voltaje de la terminal analógica A0 de la tarjeta
%v = readVoltage(a,'A0');
%Creamos el espacio para imprimir lo que leemos de la tarjeta 
figure
h = animatedline;
ax = gca;
ax.YGrid = 'on';


%Creamos un ciclo para adquirir 1000 datos 
for x=1:2000
   
    % Lee el voltaje
    c = readVoltage(a,'A0');
    % Obtiene la hora de la computadora
    T_real = Ajuste_lineal.p1*c^2+Ajuste_lineal.p2*c+Ajuste_lineal.p3;
    t =  datetime('now'); 
    % Agrega los puntos obtenidos a la gráfica
    addpoints(h,datenum(t),T_real);
    % Actualiza los datos en el eje x    
    datetick('x','keeplimits');
    ax.YLim = [5 40];
     xlabel('Tiempo (s)') 
    ylabel('Temperatura (°C)')
    drawnow
      pause(1)
end