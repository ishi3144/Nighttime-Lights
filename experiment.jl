using NighttimeLights, Rasters, Dates, Shapefile,DataFrames, Karmana

shp = Shapefile.Table("/home/ayush/nightlights/DATA/MAPS/RUSSIA_BOUNDARY/split_states.shp") |> DataFrame
shp = dropmissing(shp)

russia_index = findall( x -> x == "Voronezh", shp.NAME_1)
russia_polygon = shp.geometry[russia_index]
plot1 = plot(russia_polygon)
savefig(plot1, "file2.png")
#see mask
start_date = Date(2017, 06)
end_date = Date(2017, 06)
# radiance, ncfobs = readnl(russia_polygon, start_date, end_date)
# radiance = Float32.(radiance)
# sum(radiance)

#2017
radiance_sums = Float32[]
for month in 1:12
    start_date = Date(2017, month)
    end_date = Date(2017, month)
    radiance, ncfobs = readnl(russia_polygon, start_date, end_date)
    radiance = Float32.(radiance)
    push!(radiance_sums, sum(radiance))
end

println(radiance_sums)

#2018
radiance_sums2 = Float32[]
for month in 1:12
    start_date = Date(2018, month)
    end_date = Date(2018, month)
    radiance, ncfobs = readnl(russia_polygon, start_date, end_date)
    radiance = Float32.(radiance)
    push!(radiance_sums2, sum(radiance))
end
println(radiance_sums2)

#2019
radiance_sums3 = Float32[]
for month in 1:12
    start_date = Date(2019, month)
    end_date = Date(2019, month)
    radiance, ncfobs = readnl(russia_polygon, start_date, end_date)
    radiance = Float32.(radiance)
    push!(radiance_sums3, sum(radiance))
end
println(radiance_sums3)

#2020
radiance_sums4 = Float32[]
for month in 1:12
    start_date = Date(2020, month)
    end_date = Date(2020, month)
    radiance, ncfobs = readnl(russia_polygon, start_date, end_date)
    radiance = Float32.(radiance)
    push!(radiance_sums4, sum(radiance))
end
println(radiance_sums4)

#2021
radiance_sums5 = Float32[]
for month in 1:12
    start_date = Date(2021, month)
    end_date = Date(2021, month)
    radiance, ncfobs = readnl(russia_polygon, start_date, end_date)
    radiance = Float32.(radiance)
    push!(radiance_sums5, sum(radiance))
end
println(radiance_sums5)

using Plots
radiance_all = vcat(radiance_sums, radiance_sums2, radiance_sums3, radiance_sums4, radiance_sums5)
dates = [Date(2017, 1) + Month(i-1) for i in 1:length(radiance_all)]
p1 = plot(dates, radiance_all, color=:red, label="Radiance", ylabel="Radiance (nW/cm^2 sr)", xlabel="Year", legend=false)









# russia_mask = mask(russia_polygon, radiance) #russia's radiance data
# russia = crop(raster; to = shp.geometry[russia_index])
# russia_masked = mask(russia_polygon, with = shp.geometry[russia_index]) 



using Dates
using NighttimeLights
using Shapefile
using DataFrames

# Load shapefile and find Russia
shp = Shapefile.Table("/home/ishi.jain/in_primary_countries.shp") |> DataFrame
shp = dropmissing(shp)
russia_index = findall(x -> x == "Russia", shp.name)
russia_polygon = shp.geometry[russia_index]

function compute_radiance_sums(year)
    radiance_sums = Float32[]
    for month in 1:12
        start_date = Date(year, month)
        end_date = Date(year, month)
        radiance, ncfobs = readnl(russia_polygon, start_date, end_date)
        radiance = Float32.(radiance)
        push!(radiance_sums, sum(radiance))
    end
    return radiance_sums
end

years = 2017:2021
radiance_dict = Dict{Int, Vector{Float32}}()

for year in years
    radiance_dict[year] = compute_radiance_sums(year)
end

for year in years
    println("Radiance sums for $year: ", radiance_dict[year])
end





shp = Shapefile.Table("/home/ayush/nightlights/DATA/MAPS/RUSSIA_BOUNDARY/split_states.shp") |> DataFrame

plot1 = plot(shp.geometry)
savefig(plot1, "/home/ishi.jain/russia_split.png")
