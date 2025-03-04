<!DOCTYPE html>
<html>
<title>browser headers</title>
<head>
    <link rel="stylesheet" href="/style.css">
</head>
<body>

<?php
$headers = getallheaders();
foreach ($headers as $key=>$val) {
    echo $key . ': ' . $val . '<br>';
}
?>

</body>
</html>
