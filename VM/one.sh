#!/bin/bash


NEW_SETUP=/home/hosein/Flink_repo/Spring_2018/Host/newsetup.sh
WORKDIR=`pwd`
#echo "Enter RAM size:"
#read input[0] 
#echo "Enter RAM frequency:"
#read input[1]
#echo "Enter Memory Channel:"
#read input[2] 
#echo "Enter CPU frequency:"
#read input[3]
#echo "Enter Number of cores:"
#read input[4]

echo '-------------> Memory size (in GB) , Memory Frequency, Memory channel (1,2 or 4), 1 (CPU Frequency), 8 (Number of cores), 1 (Input size)
	-----> CPU Frequency: 0 --> 2.1 MHz
			      1 --> 1.9 MHz
			      2 --> 1.2 MHz'

#/home/hosein/Flink_repo/Spring_2018/Host/newsetup.sh

$NEW_SETUP

name=output
ext=.txt
out=$name_$1_$2_$3_$4_$5_$ext
#out=${name}_${RAM}_${RAMfreq}_${MEMchannel}_${CPUfreq}_${cores}${ext}

#/home/hosein/Flink/Spring_2018/run/pcm-memory.x ${RAM} ${RAMfreq} ${MEMchannel} ${CPUfreq} ${cores} 1 >> out
#/home/hosein/Flink/Spring_2018/run/pcm-memory.x $1 $2 $3 $4 $5 1 > $out 



out_flink=flink-$1_$2_$3_$4_$5$ext5
out_spark=spark-$1_$2_$3_$4_$5$ext
out_hadoop=hadoop-$1_$2_$3_$4_$5$ext


#Starting Flink
#cd /home/hosein/Flink/flink-0.10.0
#ssh hduser@192.168.56.101 /home/hosein/Flink/flink-0.10.0/bin/start-local.sh

#cd ${WORKDIR}

#nohup dstat -m -c -d --output stat_flink_$1_$2_$3_$4_$5.csv &
#dstatflink=$!

#./pcm-memory-flink.x $1 $2 $3 $4 $5 1 >> $out_flink
#wait

#kill -9 $dstatflink

#ssh hduser@192.168.56.101 /home/hosein/Flink/flink-0.10.0/bin/stop-local.sh 

#cd ${WORKDIR}

##Flink benchmarks finished


#Starting Spark
#ssh hduser@192.168.56.101 /home/hosein/Flink/spark/sbin/start-all.sh

#cd ${WORKDIR}
#$NEW_SETUP
#/home/hosein/Flink_repo/Spring_2018/Host/newsetup.sh

#nohup dstat -m -c -d --output stat_spark_$1_$2_$3_$4_$5.csv &
#dstatspark=$!

#./pcm-memory-spark.x $1 $2 $3 $4 $5 1 >> $out_spark
#wait

#kill -9 $dstatspark

#ssh hduser@192.168.56.101 /home/hosein/Flink/spark/sbin/stop-all.sh

##Finished Spark benchmarks


#cd ${WORKDIR}

#$NEW_SETUP
#/home/hosein/Flink/Spring_2018/run/newsetup.sh

nohup dstat -m -c -d --output stat_hadoop_$1_$2_$3_$4_$5.csv &
dstathadoop=$!
ssh hduser@192.168.56.101 $HADOOP_HOME/bin/hadoop dfsadmin -safemode leave
./pcm-memory-pagerank.x $1 $2 $3 $4 $5 1 >> $out_hadoop

kill -9 $dstathadoop

#./pcm-memory.x 16 2133 1 0 16 1 >> output.txt
