#!/bin/bash
SERVER=http://graylog-es.psamvp.hcs.harman.com:9200
CURL="echo curl"
$CURL -X PUT -H 'Content-Type: application/json' 'http://graylog-es.psamvp.hcs.harman.com:9200/_template/zeebe232h-record_job_0.23.2'  -d  @/home/ec2-user/zeebe/exporters/elasticsearch-exporter/target/classes/zeebe-record-job-template.json
INDICES=`echo zeebe232h-record_job_0.23.2_2020-06-{07,08,09,10,11}`
for I in $INDICES; do 
	$CURL -X POST -H 'Content-Type: application/json' 'http://graylog-es.psamvp.hcs.harman.com:9200/_reindex' -d '{"source": {"index":"'$I'"}, "dest": {"index": "'$I'_x","version_type": "internal"}}'
	$CURL -X DELETE -H 'Content-Type: application/json' 'http://graylog-es.psamvp.hcs.harman.com:9200/'$I
	$CURL -X POST -H 'Content-Type: application/json' 'http://graylog-es.psamvp.hcs.harman.com:9200/_reindex' -d '{"source": {"index":"'$I'_x"}, "dest": {"index": "'$I'","version_type": "internal"}}'
	$CURL -X DELETE -H 'Content-Type: application/json' 'http://graylog-es.psamvp.hcs.harman.com:9200/'$I'_x'
done
