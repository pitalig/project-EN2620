erbs;

operadora = oi;
[n m] = size(operadora);

signal_power = zeros(area_height, area_width)-1000;
erb_count = 0;

for k = 1:2:n
  erb = [dms2degrees(operadora(k,:)) dms2degrees(operadora(k+1,:))];
  if (erb(1) < coord_ne(1) && erb(1) > coord_sw(1) && erb(2) < coord_ne(2) && erb(2) > coord_sw(2))
    signal_erb = signal_test(erb);
    erb_count = erb_count + 1;
    for i = 1:area_height
      for j = 1:area_width
        signal_power(i,j) = max(signal_power(i,j), signal_erb(i,j));
      end
    end
  end
end

colormap(flipud(jet));
clims = [50 200];
imagesc(signal_power, clims);
colorbar;