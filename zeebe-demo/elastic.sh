#!/bin/bash
SERVER=http://graylog-es.psamvp.hcs.harman.com:9200
LIST=$SERVER/_cat/indices?format=json
CURL="curl -k -s"

function indices {
	$CURL "$LIST" | jq -r ".[].index" 
}

function mapping {
	$CURL "$SERVER/$1/_mapping" | jq . 
}
function query {
	$CURL -X POST "$SERVER/$1/_search" -H 'Content-Type: application/json' -d '{"query":{"query_string":{ "query": "'${2:-*}'"}}}' | jq . 
}

function delete {
	set -x
	tr '\n' ' ' | sed -e "s/ /,/g" | sed -e "s#^#$SERVER/#" | xargs $CURL -X DELETE
}

eval $1
