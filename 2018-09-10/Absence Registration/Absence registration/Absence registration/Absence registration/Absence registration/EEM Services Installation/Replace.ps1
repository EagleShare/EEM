$ConfigFile = './web.config'
## XML Node names and Attributes are CaSe SeNsItIvE!
$Key=$args[0]
$XPath = "configuration/appSettings/add[@key='"+$Key+"']"
$Attribute = "value"
$ValidPath = Test-Path $ConfigFile -IsValid
If ($ValidPath -eq $True) 
{
	Write-Host "Path is OK"
	if ($args[2] -eq $null){
		$NewValue = $args[1]
	}
	else{
		$readConfigPath=$args[2]
		$readValidPath = Test-Path $readConfigPath -IsValid
		if($readValidPath -eq $True){
			$getxml = [xml](Get-Content -Path $readConfigPath)
			$NewValue=$getxml.SelectSingleNode($XPath).value
		}
		else{
			Write-Host "Read Path is Invalid"
			return
		}
	}
		$xml = [xml](Get-Content -Path $ConfigFile)
		if($xml.SelectSingleNode($XPath).key){
			$xml.SelectSingleNode($XPath).SetAttribute($Attribute, $NewValue)
		}
		else{
			$newEl=$xml.CreateElement("add");                               # Create a new Element 
			$nameAtt1=$xml.CreateAttribute("key");                         # Create a new attribute “key” 
			$nameAtt1.psbase.value=$Key;                    # Set the value of “key” attribute 
			$newEl.SetAttributeNode($nameAtt1);                              # Attach the “key” attribute 
			$nameAtt2=$xml.CreateAttribute("value");                       # Create “value” attribute  
			$nameAtt2.psbase.value=$NewValue;                       # Set the value of “value” attribute 
			$newEl.SetAttributeNode($nameAtt2);                               # Attach the “value” attribute 
			$xml.configuration["appSettings"].AppendChild($newEl);    # Add the newly created element to the right position
		}
		$xml.Save($ConfigFile)
}
else{
	Write-Host "Path is Invalid"
}