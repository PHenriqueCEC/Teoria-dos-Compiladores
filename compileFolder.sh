#Matheus Gomes Luz Werneck (201835037) 
#Pedro Henrique Almeida Cardoso Reis (201835039)
./execJflex.sh
javac -d ./bin src/*.java
if [ $? -eq 0 ];then 
   echo "compilado com sucesso!"
   cd bin

   for file in $(find ../testes/semantica/certo -name "*.lan"); do
      # -e permite caracteres especiais
      java App $file >> "../resultados/testesCertos.txt"
      echo -e "\n------Proximoteste---------\n" >> ../resultados/testesCertos.txt
      
   done

   for file in $(find ../testes/semantica/errado -name "*.lan"); do
      java App $file >> "../resultados/testesErrados.txt"
      echo -e "\n------Proximoteste---------\n" >> ../resultados/testesErrados.txt
      
   done

else
   echo "nao compilado"
fi
