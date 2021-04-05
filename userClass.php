<?php
class userClass
{
/* User Login */
public function userLogin($usernameEmail,$password)
{
try{
$db = getDB();
$hash_password= hash('sha256', $password); //Password encryption 
$stmt = $db->prepare("SELECT id FROM account WHERE (CONCAT(etunimi, ' ', sukunimi)=:usernameEmail or email=:usernameEmail) AND salasana=:hash_password");
$stmt->bindParam("usernameEmail", $usernameEmail,PDO::PARAM_STR) ;
$stmt->bindParam("hash_password", $hash_password,PDO::PARAM_STR) ;
$stmt->execute();
$count=$stmt->rowCount();
$data=$stmt->fetch(PDO::FETCH_OBJ);
$db = null;
if($count)
{
$_SESSION['uid']=$data->uid; // Storing user session value
return true;
}
else
{
return false;
}
}
catch(PDOException $e) {
echo '{"error":{"text":'. $e->getMessage() .'}}';
}

}
}
?>