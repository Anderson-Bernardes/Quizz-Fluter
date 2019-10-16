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
    echo "Cadastrando pontuação";

    $nome       = $_GET["nome"];
    $pontos     = $_GET["pontos"];


    $sql = "INSERT INTO usuarios (nome, pontos) VALUES('".$nome."','".$pontos."')";

    echo $sql;

    //Executar Instrução de Inserção (INSERT)
    $mysqli->query($sql);

    $id = $mysqli->insert_id;

    echo "id inserido-> ".$id;

        
    //fechando a conexão com o Bando de Dados
    $mysqli->close();

?>