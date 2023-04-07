./execJflex.sh
javac -d ./bin src/*.java
if [ $? -eq 0 ];then 
   echo "compilado com sucesso!"
   cd bin
   java App ../sample1.txt

else
   echo "nao compilado"
fi