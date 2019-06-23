Get-Content $args[0] | Foreach-Object{ # ���������� ������ �� 1 ���������
   $var = $_.Split('=')
   New-Variable -Name $var[0] -Value $var[1]
}
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection # ������� ������ ���������� 
$SqlConnection.ConnectionString = "Server=$serverName; Database=$instanceName; User ID=$userName; Password=$userPwd;" # ��������� ������ �����������
$SqlConnection.Open() # ��������� ����������
$SqlCmd = $SqlConnection.CreateCommand() # ������� ������
$SqlCmd.CommandText = Get-Content $args[1] # �������� ����� ������� �� ����� 2 ���������
$objReader = $SqlCmd.ExecuteReader() # ��������� ������
while ($objReader.read()) {
  echo $objReader.GetValue(0) # ������� ��������� �������
}
$objReader.close() # ��������� Reader ����������
$SqlConnection.close() # ��������� ����������