function signal_power = signal_test( erb_coords )

% load workspace vars
evalin('base','save myvars.mat');
load myvars.mat;

% Antenna data: http://www.fujitsu.com/downloads/MAG/vol38-2/paper07.pdf
up_freq = 1950; % MHz
down_freq = 2140; % MHz
freq = down_freq;
Pot_t = 80; % W
G_t = 1;
G_r = 1;
c=3e8;
lamb= c/freq;

h_receptor = 1.10;
h_erb = 10;

i = find(lat_simple>=erb_coords(1),1);
j = find(lon_simple>=erb_coords(2),1);
erb_alt = alt(i,j) + 10;

signal_power = zeros(area_height, area_width);
for i = 1:area_height
  for j = 1:area_width
    receptor_alt = alt(i,j) + h_receptor;
    alt_diff = abs(erb_alt-receptor_alt)/1000;
    distance = dist(erb_coords, [lat(i,j),lon(i,j)], alt_diff);
    
    % Here you can choose the propagation model:
    
    % Espaço Livre
    % gama = 2;
    % signal_power(i,j) = 10*log10(Pot_t/10e-3) + 10*log10(G_t*G_r) - 20*log10(freq) - 20*log10(distance) + (27.558 - 10*gama*log10(1e3));
    
    % Espaço Livre db
    gama = 2;
    signal_power(i,j) = 10 * log10((G_t*G_r * Pot_t * (lamb/(4*pi*distance))^2)/1e-3);
    
    % Espaço Livre modificado
    % gama = 4;
    % signal_power(i,j) = 10*log10(Pot_t/10e-3) + 10*log10(G_t*G_r) - 20*log10(freq) - 10*gama*log10(distance) + (27.558 - 10*gama*log10(1e3));
    
    % Espaço Livre modificado db
    % gama = 4;
    % signal_power(i,j) = 10 * log10((G_t*G_r * Pot_t/(distance^gama) * (lamb/(4*pi))^2)/1e-3);
    
    
    % Ray Tracing db
    % signal_power(i,j) = 10 * log10((G_t*G_r*Pot_t*(lamb/(2*pi*distance))^2*sin(2*pi*h_erb*h_receptor/(lamb*distance))^2)/1e-3);
  end
end

end

