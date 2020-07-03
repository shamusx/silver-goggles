#vsphere7 - content library template version check
$content_lib_name = LAB-CL
$template_name = "k8-template"

$vCenterServer = "vcsa.zoo.lab"
$vCenterUser = "administrator@vsphere.local"
$vCenterPassword = "password123"

Connect-VIServer -Server $vCenterServer -Protocol https -User $vCenterUser -Password $vCenterPassword

$content_library = Get-ContentLibraryItem -Name $template_name -ContentLibrary $content_lib_name
$content_library.Name | Should -Be $template_name
$contentlibrary_item_cis = Get-CisService 'com.vmware.content.library.item' -Server $vCenterServer
$contentlibrary_search = $contentlibrary_item_cis.get($content_library.id)
$contentlibrary_search.content_version.Value | Should -BeGreaterOrEqual 2
