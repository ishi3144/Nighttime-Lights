using Shapefile
using DataFrames
using NighttimeLights
using Rasters
using Dates
using Plots

## source: https://gadm.org/download_country.html
shp = Shapefile.Table("../DATA/MAPS/RUSSIA_BOUNDARY/split_states.shp") |> DataFrame
shp = dropmissing(shp)

radiance, ncfobs = readnl(city_polygon , start_date, end_date)
function compute_radiance_sums(year, city_polygon) 
    radiance_sums = Float32[]
    for month in 1:12
        start_date = Date(year, month)
        end_date = Date(year, month)
        radiance, ncfobs = readnl(city_polygon , start_date, end_date)
        radiance = Float32.(radiance)
        push!(radiance_sums, sum(radiance))
    end
    return radiance_sums
end

function compute_ncfobs_sums(year, city_polygon)
    ncfobs_sums = Float32[]
    for month in 1:12
        start_date = Date(year, month)
        end_date = Date(year, month)
        radiance, ncfobs = readnl(city_polygon, start_date, end_date)
        ncfobs = Float32.(ncfobs)
        push!(ncfobs_sums, sum(ncfobs))
    end
    return ncfobs_sums
end

years = 2017:2022


#Krasnoyarskiy
Krasnoyarskiy_index = findall( x -> x == "Krasnoyarskiy Kray|Yeniseisk|Yen", shp.VARNAME_1)
Krasnoyarskiy_polygon = shp.geometry[Krasnoyarskiy_index]

start_date = Date(2017)
end_date = Date(2018)
years = start_date:Month(1):end_date
start_date = Date(2017, 06)
end_date = Date(2018, 06)
radiance, ncfobs = readnl(Krasnoyarskiy_polygon, start_date, end_date)

radiance_dict_Krasnoyarskiy = Dict{Int, Vector{Float32}}()
ncfobs_dict_Krasnoyarskiy = Dict{Int, Vector{Float32}}()

for year in years
    radiance_dict_Krasnoyarskiy[year] = compute_radiance_sums(year, Krasnoyarskiy_polygon )
    ncfobs_dict_Krasnoyarskiy[year] = compute_ncfobs_sums(year, Krasnoyarskiy_polygon)
end

for year in years
    println("Radiance sums for $year: ", radiance_dict_Krasnoyarskiy[year])
    println("ncfobs sums for $year: ", ncfobs_dict_Krasnoyarskiy[year])
end



