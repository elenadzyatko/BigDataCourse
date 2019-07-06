#!/usr/bin/env bash
#set -x

HADOOP_STREAMING_JAR="/opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/hadoop-streaming.jar"
HDFS_OUTPUT_DIR=hw3_mr_advanced_output

hdfs dfs -rm -r -skipTrash $HDFS_OUTPUT_DIR > /dev/null;
hdfs dfs -rm -r -skipTrash ${HDFS_OUTPUT_DIR}_tmp > /dev/null;

(yarn jar $HADOOP_STREAMING_JAR \
        -files mapper.py,reducer.py \
        -mapper 'python3 mapper.py' \
        -reducer 'python3 reducer.py' \
        -numReduceTasks 8 \
        -input /data/socnet_urls \
        -output ${HDFS_OUTPUT_DIR}_tmp > /dev/null&&
yarn jar $HADOOP_STREAMING_JAR \
        -D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
        -D mapreduce.partition.keypartitioner.options=-k1,1 \
        -D mapreduce.partition.keycomparator.options='-k1,1 -k3,3nr' \
        -D stream.num.map.output.key.fields=3 \
        -files head.py \
        -mapper cat \
        -reducer 'python3 head.py' \
        -numReduceTasks 1 \
        -input ${HDFS_OUTPUT_DIR}_tmp \
        -output ${HDFS_OUTPUT_DIR} \
        -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner > /dev/null)

hdfs dfs -cat $HDFS_OUTPUT_DIR/part-00000
hdfs dfs -rm -r -skipTrash ${HDFS_OUTPUT_DIR}_tmp > /dev/null;
#echo $?
 
