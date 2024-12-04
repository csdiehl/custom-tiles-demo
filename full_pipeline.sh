# path to original shapefile
file=gis_osm_waterways_free_1.shp

# prepare data
mapshaper ./input/$file \
-filter 'fclass != "canal"' \
-filter-fields fclass \
-dissolve fclass \
-simplify 20% \
-o ./output/waterways.geojson

# create tiles
tippecanoe -zg -o ./output/waterways.mbtiles \
-l waterways \
 --drop-densest-as-needed \
 --no-tile-compression \
 --force \
 output/waterways.geojson

# extract tiles
mb-util ./output/waterways.mbtiles --image_format=pbf ./output/tiles

# upload to S3 tile server
aws s3 sync ./output/tiles s3://tileserver.ap.org/projects/map_demo/tiles \
 --acl public-read