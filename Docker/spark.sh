#!/bin/bash



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
/home/hosein/Flink_repo/Spring_2018/run_Docker/newsetup.sh

name=output
ext=.txt
out=$name_$1_$2_$3_$4_$5_$ext
#out=${name}_${RAM}_${RAMfreq}_${MEMchannel}_${CPUfreq}_${cores}${ext}

#/home/hosein/Flink/Spring_2018/run/pcm-memory.x ${RAM} ${RAMfreq} ${MEMchannel} ${CPUfreq} ${cores} 1 >> out
#/home/hosein/Flink/Spring_2018/run/pcm-memory.x $1 $2 $3 $4 $5 1 > $out 


out_flink=flink-$1_$2_$3_$4_$5$ext
out_spark=spark-$1_$2_$3_$4_$5$ext
out_hadoop=hadoop-$1_$2_$3_$4_$5$ext


#Starting Flink
#docker container exec bigdata $FLINK_HOME/bin/start-local.sh

#cd ${WORKDIR}

#dstat on host machine
#nohup dstat -m -c -d --output stat_flink_$1_$2_$3_$4_$5.csv &
#dstatflink=$!
#dstat on Docker
#docker container exec bigdata nohup dstat -m -c -d --output stat_docker_flink_$1_$2_$3_$4_$5.csv >> stat_output &
dstatflink_docker=$!

#./pcm-memory-flink.x $1 $2 $3 $4 $5 1 >> $out_flink
#wait

#Killing the stat processes
#kill -9 $dstatflink_docker
#kill -9 $dstatflink

#Stopping Flink
#docker container exec bigdata $FLINK_HOME/bin/stop-local.sh

#cd ${WORKDIR}

########################------------------------------------------------Flink benchmarks finished

/home/hosein/Flink_repo/Spring_2018/run_Docker/newsetup.sh

docker container exec bigdata $HADOOP_HOME/bin/hadoop dfsadmin -safemode leave

########################------------------------------------------------------SPARK BENCHMARKS
##Starting Spark
docker container exec bigdata $SPARK_HOME/sbin/start-all.sh

#cd ${WORKDIR}
#/home/hosein/Flink/Spring_2018/run/newsetup.sh

#dstat on host machine
nohup dstat -m -c -d --output stat_spark_$1_$2_$3_$4_$5.csv &
dstatspark=$!
#dstat on Docker
docker container exec bigdata nohup dstat -m -c -d --output stat_docker_flink_$1_$2_$3_$4_$5.csv >> stat_output &
dstatspark_docker=$!

./pcm-memory-spark.x $1 $2 $3 $4 $5 1 >> $out_spark
#wait

kill -9 $dstatspark
kill -9 $dstatspark_docker

#Stopping Spark
docker container exec bigdata $SPARK_HOME/sbin/stop-all.sh

#######################----------------------------------------------Finished Spark benchmarks

/home/hosein/Flink_repo/Spring_2018/run_Docker/newsetup.sh

docker container exec bigdata $HADOOP_HOME/bin/hadoop dfsadmin -safemode leave
#######################----------------------------------------------------HADOOP BENCHMARKS
#cd ${WORKDIR}

#/home/hosein/Flink/Spring_2018/run/newsetup.sh

#nohup dstat -m -c -d --output stat_hadoop_$1_$2_$3_$4_$5.csv &
#dstathadoop=$!

#docker container exec bigdata nohup dstat -m -c -d --output stat_docker_flink_$1_$2_$3_$4_$5.csv >> stat_output &
#dstathadoop_docker=$!

#./pcm-memory-hadoop.x $1 $2 $3 $4 $5 1 >> $out_hadoop

#kill -9 $dstathadoop
#kill -9 $dstathadoop_docker

#./pcm-memory.x 16 2133 1 0 16 1 >> output.txt
