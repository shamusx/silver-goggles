#vsphere7 - Latest Checked In Template
$content_lib_name = LAB-CL
$template_name = "k8-template"

$vCenterServer = "vcsa.zoo.lab"
$vCenterUser = "administrator@vsphere.local"
$vCenterPassword = "password123"

Connect-VIServer -Server $vCenterServer -Protocol https -User $vCenterUser -Password $vCenterPassword

$content_template_info = Get-Template -Name $template_name* | Get-View
$template_inventory = ForEach ($template in $content_template_info)
{ 
"" | Select-Object -Property @{N="Name";E={$template.Name}},
    @{N="Timestamp";E={$template.config.ChangeVersion}},
    @{N="Memory";E={$template.config.Hardware.MemoryMB}},
    @{N="CPU";E={$template.config.Hardware.NumCPU}}  
}
$template_inventory | Sort-Object -Property Timestamp -Descending |  Select-Object -First 1
