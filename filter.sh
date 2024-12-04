# filter out canals
file=gis_osm_waterways_free_1.shp
mapshaper ./input/$file \
-filter 'fclass != "canal"' \
-filter-fields fclass \
-dissolve fclass \
-simplify 20% \
-o ./output/waterways.geojson