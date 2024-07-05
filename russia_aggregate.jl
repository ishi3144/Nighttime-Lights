using Shapefile
using DataFrames
using NighttimeLights
using Rasters
using Dates
using Plots
## source: https://gadm.org/download_country.html
shp = Shapefile.Table("../DATA/MAPS/RUSSIA_BOUNDARY/split_states.shp") |> DataFrame
shp = dropmissing(shp)
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
City_index = findall( x -> x == "City", shp.ENGTYPE_1)
City_polygon = shp.geometry[City_index]
radiance_dict_City = Dict{Int, Vector{Float32}}()
ncfobs_dict_City = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_City[year] = compute_radiance_sums(year, City_polygon)
    ncfobs_dict_City[year] = compute_ncfobs_sums(year, City_polygon)
end
Territory_index = findall( x -> x == "Territory", shp.ENGTYPE_1)
Territory_polygon = shp.geometry[Territory_index][1:8]
radiance_dict_Territory = Dict{Int, Vector{Float32}}()
ncfobs_dict_Territory = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_Territory[year] = compute_radiance_sums(year, Territory_polygon)
    ncfobs_dict_Territory[year] = compute_ncfobs_sums(year, Territory_polygon)
end
#terminal crashed
Territory_polygon_half = shp.geometry[Territory_index][8:16]
radiance_dict_Territory_half = Dict{Int, Vector{Float32}}()
ncfobs_dict_Territory_half = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_Territory_half[year] = compute_radiance_sums(year, Territory_polygon_half)
    ncfobs_dict_Territory_half[year] = compute_ncfobs_sums(year, Territory_polygon_half)
end
Republic_index = findall( x -> x == "Republic", shp.ENGTYPE_1)
Republic_polygon_first = shp.geometry[Republic_index][1:7]
#terminal crashed for 1:10
radiance_dict_republic_first = Dict{Int, Vector{Float32}}()
ncfobs_dict_republic_first = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_republic_first[year] = compute_radiance_sums(year, Republic_polygon_first)
    ncfobs_dict_republic_first[year] = compute_ncfobs_sums(year, Republic_polygon_first)
end
Republic_polygon_second = shp.geometry[Republic_index][8:14]
radiance_dict_republic_second = Dict{Int, Vector{Float32}}()
ncfobs_dict_republic_second = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_republic_second[year] = compute_radiance_sums(year, Republic_polygon_second)
    ncfobs_dict_republic_second[year] = compute_ncfobs_sums(year, Republic_polygon_second)
end
Republic_polygon_third = shp.geometry[Republic_index][15:21]
radiance_dict_republic_third = Dict{Int, Vector{Float32}}()
ncfobs_dict_republic_third = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_republic_third[year] = compute_radiance_sums(year, Republic_polygon_third)
    ncfobs_dict_republic_third[year] = compute_ncfobs_sums(year, Republic_polygon_third)
end
Republic_polygon_fourth = shp.geometry[Republic_index][22:28]
radiance_dict_republic_fourth = Dict{Int, Vector{Float32}}()
ncfobs_dict_republic_fourth = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_republic_fourth[year] = compute_radiance_sums(year, Republic_polygon_fourth)
    ncfobs_dict_republic_fourth[year] = compute_ncfobs_sums(year, Republic_polygon_fourth)
end
Province_index = findall( x -> x == "Autonomous Province", shp.ENGTYPE_1)
Province_polygon_first = shp.geometry[Province_index][1]
radiance_dict_province_first = Dict{Int, Vector{Float32}}()
ncfobs_dict_province_first = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_province_first[year] = compute_radiance_sums(year, Province_polygon_first)
    ncfobs_dict_province_first[year] = compute_ncfobs_sums(year, Province_polygon_first)
end
Province_polygon_second = shp.geometry[Province_index][2:3]
radiance_dict_province_second = Dict{Int, Vector{Float32}}()
ncfobs_dict_province_second = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_province_second[year] = compute_radiance_sums(year, Province_polygon_second)
    ncfobs_dict_province_second[year] = compute_ncfobs_sums(year, Province_polygon_second)
end
Province_polygon_third = shp.geometry[Province_index][4]
radiance_dict_province_third = Dict{Int, Vector{Float32}}()
ncfobs_dict_province_third = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_province_third[year] = compute_radiance_sums(year, Province_polygon_third)
    ncfobs_dict_province_third[year] = compute_ncfobs_sums(year, Province_polygon_third)
end
Region_index = findall( x -> x == "Region", shp.ENGTYPE_1)
Region_polygon_first = shp.geometry[Region_index][1]
radiance_dict_region_first = Dict{Int, Vector{Float32}}()
ncfobs_dict_region_first = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_region_first[year] = compute_radiance_sums(year, Region_polygon_first)
    ncfobs_dict_region_first[year] = compute_ncfobs_sums(year, Region_polygon_first)
end
Region_polygon_second = shp.geometry[Region_index][2]
radiance_dict_region_second = Dict{Int, Vector{Float32}}()
ncfobs_dict_region_second = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_region_second[year] = compute_radiance_sums(year, Region_polygon_second)
    ncfobs_dict_region_second[year] = compute_ncfobs_sums(year, Region_polygon_second)
end
Region_polygon_third = shp.geometry[Region_index][3:10]
radiance_dict_region_third = Dict{Int, Vector{Float32}}()
ncfobs_dict_region_third = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_region_third[year] = compute_radiance_sums(year, Region_polygon_third)
    ncfobs_dict_region_third[year] = compute_ncfobs_sums(year, Region_polygon_third)
end
Region_polygon_fourth = shp.geometry[Region_index][10:20]
radiance_dict_region_fourth = Dict{Int, Vector{Float32}}()
ncfobs_dict_region_fourth = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_region_fourth[year] = compute_radiance_sums(year, Region_polygon_fourth)
    ncfobs_dict_region_fourth[year] = compute_ncfobs_sums(year, Region_polygon_fourth)
end
Region_polygon_fifth = shp.geometry[Region_index][20:30]
radiance_dict_region_fifth = Dict{Int, Vector{Float32}}()
ncfobs_dict_region_fifth = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_region_fifth[year] = compute_radiance_sums(year, Region_polygon_fifth)
    ncfobs_dict_region_fifth[year] = compute_ncfobs_sums(year, Region_polygon_fifth)
end
Region_polygon_sixth = shp.geometry[Region_index][30:40]
radiance_dict_region_sixth  = Dict{Int, Vector{Float32}}()
ncfobs_dict_region_sixth  = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_region_sixth[year] = compute_radiance_sums(year, Region_polygon_sixth )
    ncfobs_dict_region_sixth[year] = compute_ncfobs_sums(year, Region_polygon_sixth )
end
Region_polygon_seventh = shp.geometry[Region_index][40:46]
radiance_dict_region_seventh  = Dict{Int, Vector{Float32}}()
ncfobs_dict_region_seventh  = Dict{Int, Vector{Float32}}()
for year in years
    radiance_dict_region_seventh[year] = compute_radiance_sums(year, Region_polygon_seventh)
    ncfobs_dict_region_seventh[year] = compute_ncfobs_sums(year, Region_polygon_seventh)
end
using DataFrames
# Function to merge radiance and ncfobs dictionaries into a single DataFrame
function merge_dicts_into_df(dicts...)
    years = sort(collect(keys(dicts[1][2])))  # Assumes all dicts have the same years
    columns = ["Year"]
    for dict_type in dicts
        region_type = dict_type[1]  # Example: "City", "Territory", etc.
        for month in 1:12
            push!(columns, "Radiance_$(region_type)_Month_$month")
            push!(columns, "NCFOBS_$(region_type)_Month_$month")
        end
    end
    println("Expected number of columns: ", length(columns))
    data = Vector{Vector{Any}}()  # Use Vector{Vector{Any}} to store mixed types
    for year in years
        row = Vector{Any}(undef, length(columns))  # Initialize with the expected number of columns
        row[1] = year
        col_index = 2
        for dict_type in dicts
            radiance_dict, ncfobs_dict = dict_type[2], dict_type[3]
            if haskey(radiance_dict, year) && haskey(ncfobs_dict, year)
                for i in 1:12
                    row[col_index] = radiance_dict[year][i]
                    row[col_index + 1] = ncfobs_dict[year][i]
                    col_index += 2
                end
            else
                for _ in 1:12
                    row[col_index] = 0.0f0
                    row[col_index + 1] = 0.0f0
                    col_index += 2
                end
            end
        end
        if length(row) != length(columns)
            println("Row length: ", length(row))
            println("Row data: ", row)
        end
        push!(data, row)
    end
    return DataFrame(data, Symbol.(columns))
end
# Create tuples of region type, radiance dict, and ncfobs dict
dicts = [
    ("City", radiance_dict_City, ncfobs_dict_City),
    ("Territory", radiance_dict_Territory, ncfobs_dict_Territory),
    ("Territory_half", radiance_dict_Territory_half, ncfobs_dict_Territory_half),
    ("Republic_first", radiance_dict_republic_first, ncfobs_dict_republic_first),
    ("Republic_second", radiance_dict_republic_second, ncfobs_dict_republic_second),
    ("Republic_third", radiance_dict_republic_third, ncfobs_dict_republic_third),
    ("Republic_fourth", radiance_dict_republic_fourth, ncfobs_dict_republic_fourth),
    ("Province_first", radiance_dict_province_first, ncfobs_dict_province_first),
    ("Province_second", radiance_dict_province_second, ncfobs_dict_province_second),
    ("Province_third", radiance_dict_province_third, ncfobs_dict_province_third),
    ("Region_first", radiance_dict_region_first, ncfobs_dict_region_first),
    ("Region_second", radiance_dict_region_second, ncfobs_dict_region_second),
    ("Region_third", radiance_dict_region_third, ncfobs_dict_region_third),
    ("Region_fourth", radiance_dict_region_fourth, ncfobs_dict_region_fourth),
    ("Region_fifth", radiance_dict_region_fifth, ncfobs_dict_region_fifth),
    ("Region_sixth", radiance_dict_region_sixth, ncfobs_dict_region_sixth),
    ("Region_seventh", radiance_dict_region_seventh, ncfobs_dict_region_seventh)
]
# Print dictionaries for debugging
for dict_type in dicts
    println("Region: $(dict_type[1])")
    println("Radiance Dict: $(dict_type[2])")
    println("NCFOBS Dict: $(dict_type[3])")
end
# Create the combined DataFrame
combined_df = merge_dicts_into_df(dicts...)
# Display the DataFrame
println(combined_df)
