function elev=elevation(lat,lon)
maps_api='https://maps.googleapis.com/maps/api/elevation/json?locations=';
api_key=strcat('&key=','APIKEY');

[height width] = size(lat);
req_size = 400;
num_of_reqs = floor(width/req_size);
last_req_size = mod(width, req_size);
latlon = strings(1,req_size);
elev = [];

for i = 1:num_of_reqs
  for j = 1:req_size
    latlon(j) = strcat(num2str(lat((i-1)*req_size + j)), ',', num2str(lon((i-1)*req_size + j)));
  end
  locations = strjoin(latlon,'|');
  url = strcat(maps_api,locations,api_key);
  req = webread(url);
  todo = num_of_reqs-i
  elev = [elev [req.results.elevation]];
end


latlon = strings(1,last_req_size);
for j = 1:last_req_size
  latlon(j) = strcat(num2str(lat(num_of_reqs*req_size + j)), ',', num2str(lon(num_of_reqs*req_size + j)));
end
locations = strjoin(latlon,'|');
url = strcat(maps_api,locations,api_key);
req = webread(url);
elev = [elev [req.results.elevation]];

end