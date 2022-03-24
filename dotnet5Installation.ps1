function CreateTempDir(){
    ## Create a temp folder on the C drive
    Write-Host "Crafting TEMP directory on C:\."
    New-Item -ItemType Directory -Force -Path C:\Temp | Out-Null
}

function DownloadDotNetInstaller(){
    ## Download the .net 5.0 installation file
    Write-Host "Downloading the .net 5.0.0 installer."
    $url = "https://download.visualstudio.microsoft.com/download/pr/2892493e-df43-409e-af68-8b14aa75c029/53156c889fc08f01b7ed8d7135badede/dotnet-sdk-5.0.100-win-x64.exe"
    $output = "c:\Temp\dotnet5.exe"

    try
        {
            $response = Invoke-WebRequest -Uri $url -OutFile $output -ErrorAction Stop
            $statusCode = $response.statusCode
        }
    
    catch
    {
        $statusCode = $_.Exception.Response.StatusCode.Value__
    }
    if ($statusCode){
        return $False
    }else{
        return $True
    }
}

function RunInstaller(){
    ## Run the installer silently
    c:\Temp\dotnet5.exe /install /quiet /norestart
}

if (DownloadDotNetInstaller){
    ##download ok, starting the installation
    RunInstaller
    Write-Host "Running the installation media for Dotnet 5.0"
    Exit
}