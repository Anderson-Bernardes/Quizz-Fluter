<?PHP
    //Mostrar erros
    ini_set('display_errors',1);
    ini_set('log_errors',1);
    ini_set('errors_log',dirname(__FILE__).'/error_log.txt');
    error_reporting(E_ALL);

    //Informando o Content-type
    header("Content-type: text/json; charset=utf-8");

    //Difinir o Time Zone
    date_default_timezone_set('America/Sao_Paulo');
    
    //Criando Conexão Com o Banco de Dados
    $mysqli = new mysqli('den1.mysql5.gear.host','qualeamusica', 'Et326!og72J?', 'qualeamusica'); 

    $sql = "SELECT * FROM usuarios ORDER BY pontos DESC";

    $resposta = $mysqli->query($sql);

        //print_r($resposta);
$tabela = "usuarios";
        //Criar array para o Json
        $array_tabela  = array();
        $listaAux = array();
        while($linha = mysqli_fetch_array($resposta)){
            foreach($linha as $key => $conteudo){
                if(!is_numeric($key)){
                    $listaAux[$key] = $conteudo;
                }
            }
            array_push($array_tabela, $listaAux);
        }
        
        //Mostrar esse Json na Tela
        echo json_encode(array($tabela=>$array_tabela),JSON_UNESCAPED_SLASHES|JSON_UNESCAPED_UNICODE);

        //Fechamento do Banco de Dados
    $mysqli->close();
        
    ?>