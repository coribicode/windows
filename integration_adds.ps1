$hostname = 'vm002'
$dns1 = '192.168.0.119'
$dns2 = '8.8.8.8'

$domain = 'VIRTUALEASY.LANNET'
$username = "$domain\administrator"

$pwddom = 'Passw0rd$2' | ConvertTo-SecureString -asPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username,$pwddom);

Get-NetIPv6Protocol | fl RandomizeIdentifiers
Set-NetIPv6Protocol -RandomizeIdentifiers Disabled
Get-NetIPv6Protocol | fl RandomizeIdentifiers

Get-NetAdapterBinding -ComponentID ms_tcpip6
Disable-NetAdapterBinding -InterfaceAlias "Ethernet" -ComponentID ms_tcpip6
Get-NetAdapterBinding -ComponentID ms_tcpip6

$interface = Get-NetIPConfiguration | Where-Object {$_.IPv4DefaultGateway -ne $null} | findstr Index
$index = ($interface.Split())[-1]
Set-DNSClientServerAddress -InterfaceIndex "$index" –ServerAddresses ("$dns1","$dns2")

Restart-NetAdapter -InterfaceAlias "$(($(Get-NetIPConfiguration | Where-Object {$_.IPv4DefaultGateway -ne $null} | findstr Alias).Split())[-1])"

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0

netsh advfirewall firewall add rule name="Allow ICMPv4" protocol=icmpv4:8,any dir=in action=allow

Add-Computer -DomainName $domain -Credential $credential -NewName $hostname -Restart
