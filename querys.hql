CREATE TABLE hive_features
(
feature_id 		BIGINT,
feature_name 	STRING,
feature_class	STRING,
state_alpha		STRING,
prim_last_doc	DOUBLE,
prim_long_dec	DOUBLE,
elev_in_ft		BIGINT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n';

CREATE EXTERNAL TABLE ddb_features
(
feature_id 		BIGINT,
feature_name 	STRING,
feature_class	STRING,
state_alpha		STRING,
prim_last_doc	DOUBLE,
prim_long_dec	DOUBLE,
elev_in_ft		BIGINT)
STORED BY 'org.apache.hadoop.hive.dynamodb.DynamoDBStorageHandler'
TBLPROPERTIES(
"dynamodb.table.name" = "Features",
"dynamodb.column.mapping" = "feature_id:Id,feature_name:Name,feature_class:Class,state_alpha:State,prim_last_doc:Latitude,prim_long_dec:Longitude,elev_in_ft:Elevation"
);

INSERT OVERWRITE TABLE ddb_features
SELECT
feature_id,
feature_name,
feature_class,
state_alpha,
prim_last_doc,
prim_long_doc,
elev_in_ft
FROM hive_features;

SELECT feature_name, state_alpha FROM ddb_features WHERE feature_class = 'Lake' AND feature_name LIKE 'M%' ORDER BY feature_name;

