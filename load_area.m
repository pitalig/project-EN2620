% Running this file take some time because it does a lot of requests to
% google maps to get altitudes, so if you want to use the same coordinates
% and precision from here, just load precision10000.mat into your workspace
% and it will already load all needed variables.

% Analyzed coordinates 
coord_ne = [-23.645858, -46.501556]; % biggest
coord_sw = [-23.670038, -46.542925]; % smallest
coord_nw = [-23.645858, -46.542925];
coord_se = [-23.670038, -46.501556];

% Defines the precision of the analysis (recomended = 10000)
% Bigger precision will increase the details but also the processing time
precision=10000;

% Define area matrix dimensions
area_height = round((coord_ne(1)-coord_sw(1))*precision);
area_width = round((coord_ne(2)-coord_sw(2))*precision);

% Create vectors (lat_v, lon_v and alt_v) for each coordinate pair to be analysed
lat_v = zeros(1, area_height * area_width);
lon_v = zeros(1, area_height * area_width);

for i = 1:area_height
  for j = 1:area_width
    lat_v((i-1)*area_width + j) = coord_sw(1)+((i-1)/precision);
    lon_v((i-1)*area_width + j) = coord_sw(2)+((j-1)/precision);
  end
end

% Get altitudes of the coordinates on google api
%alt_v = elevation(lat_v,lon_v);

% Transform vectors in matrices 
lat = zeros(area_height, area_width);
lon = zeros(area_height, area_width);
alt = zeros(area_height, area_width);
area = zeros(area_height, area_width,2);

for i = 1:area_height
  for j = 1:area_width
    lat(i,j) = lat_v((i-1)*area_width + j);
    lon(i,j) = lon_v((i-1)*area_width + j);
    alt(i,j) = alt_v((i-1)*area_width + j);
  end
end

% Some other simple approaches
lat_simple = lat(:,1);
lon_simple = lon(1,:).';