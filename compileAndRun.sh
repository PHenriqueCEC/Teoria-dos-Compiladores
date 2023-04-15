#Matheus Gomes Luz Werneck (201835037) 
#Pedro Henrique Almeida Cardoso Reis (201835039)
./execJflex.sh
javac -d ./bin src/*.java
if [ $? -eq 0 ];then 
   echo "compilado com sucesso!"
   cd bin
   java App $1

else
   echo "nao compilado"
fi