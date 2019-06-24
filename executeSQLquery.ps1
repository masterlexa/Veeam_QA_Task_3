Get-Content $args[0] | Foreach-Object{ # подгружаем конфиг из 1 параметра
   $var = $_.Split('=')
   New-Variable -Name $var[0] -Value $var[1]
}
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection # Создаем объект соединения 
$SqlConnection.ConnectionString = "Server=$serverName; Database=$instanceName; User ID=$userName; Password=$userPwd;" # Формируем строку подключения
$SqlConnection.Open() # Открываем соединение
$SqlCmd = $SqlConnection.CreateCommand() # Создаем запрос
$SqlCmd.CommandText = Get-Content $args[1] # Получаем текст запроса из файла 2 параметра
$objReader = $SqlCmd.ExecuteReader() # Выполняем запрос, читаем результат
while ($objReader.read()) {
  echo $objReader.GetValue(0) # Выводим результат запроса
}
$objReader.close() # Закрываем Reader результата
$SqlConnection.close() # Закрываем соединение
