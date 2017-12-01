echo "Execute robot framework: Connect to Oracle, test on sample project services"
HOSTNAME=$1
PORT=$2
DBURL=$3
pwd
pybot --variable hostname:${HOSTNAME} --variable port:${PORT} --variable dbConnectionStr:${DBURL} robot/tests/sampletest.robot
