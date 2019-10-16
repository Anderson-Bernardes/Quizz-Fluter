<?PHP
    //Mostrar erros
    ini_set('display_errors',1);
    ini_set('log_errors',1);
    ini_set('errors_log',dirname(__FILE__).'/error_log.txt');
    error_reporting(E_ALL);

    //Difinir o Time Zone
    date_default_timezone_set('America/Sao_Paulo');
    
    //Criando Conexão Com o Banco de Dados
   $mysqli = new mysqli('den1.mysql5.gear.host','qualeamusica', 'Et326!og72J?', 'qualeamusica');
echo "Antes do get";
    $nome   = $_GET["nome"];
    $id     = $_GET["id"];
echo "Antesd da string";
   $sql = "UPDATE usuarios SET nome= '".$nome."' WHERE id=".$id."";
   echo $sql;
   $res = $mysqli->query($sql);

   $mysqli->close();
   ?>