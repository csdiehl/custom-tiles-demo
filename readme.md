# Command-line cartography tools demo

Caleb Diehl

This is a demo to show how to create and host your own vector tiles.

I removed the source data because it's too large. You can create an `input` and `output` directory and get a waterway OSM extract from (Geofabrik)[https://download.geofabrik.de/north-america.html] to follow along. 

## Filter.sh

This single line of mapshaper CLI code does 5 things!

- filters out canals
- removes unessecary fields
- dissolves all the streams and rivers into single features to save processing time
- simplifies polylines to 20% of their original detail
- converts the shapefile to a geojson

## tiles.sh

Using tippecanoe we turn geojson into mbtiles.

It's critical to use the `--no-tile-compression` flag. Otherwise Maplibre will not be able to read your tiles!

## tile_folder.sh

This takes the single .mbtiles folder and expands it into a directory structure, kind of like unzipping a file. We need to do this because we are rolling our own tileserver.

Make sure to use `--image_format=pbf ` because the default is png, which are raster tiles (images). We want PBF, which is a binary file used for vector tiles that enables smooth zooming and panning.

## upload.sh

This simply recursively copies the tile directory and all its sub-directories on to S3 and ensures anyone can read the data.
