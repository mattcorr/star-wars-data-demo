function Invoke-StarWarsApi
{
    param (
        [Parameter(Mandatory)]
        [ValidateSet('Planets', 'Films', "People")]
        [string] $objectType,

        [int] $id = -1 
    )
    try {
        $suffix = $id -ne -1 ? "/$id" : ""
        $path = "$($objectType.ToLower())$suffix"

        $output = Invoke-RestMethod -Uri "https://swapi-deno.azurewebsites.net/api/$path" -Method GET
        Write-Output $output
    }
    catch {
        Write-Host "Error calling https://swapi-deno.azurewebsites.net/api/$path. $($_.Exception.Message)" -f Red
        Write-Output $null
    }
}

function Search-SWPerson {
    param (
        [Parameter(Mandatory)]
        [string] $Name
    )
    # load all the people
    $response = Invoke-StarWarsApi -objectType People
    # filter on the name
    $results = $response | Where-Object name -like "*$Name*" 

    if ($results -eq $null) {
        Write-Host "No person results found for '$Name'." -f Yellow
    }
    else {
        # return all matches with some properties
        Write-Output $results | Select-Object @{N="id";E={$_.url}}, name, gender, height, @{N="weight";E={$_.mass}}
    }
}

function Search-SWPlanet {
    param (
        [Parameter(Mandatory)]
        [string] $Name
    )
    # load all the planets
    $response = Invoke-StarWarsApi -objectType Planets
    # filter on the name
    $results = $response | Where-Object name -like "*$Name*" 

    if ($results -eq $null) {
        Write-Host "No planet results found for '$Name'." -f Yellow
    }
    else {
        # return all matches with some attributes
        Write-Output $results | Select-Object @{N="id";E={$_.url}}, name, population, diameter, terrain
    }
}

function Get-SWPerson {
    param (
        [Parameter(Mandatory)]
        [int] $Id
    )
    # get the person
    $person = Invoke-StarWarsApi -objectType People -id $Id

    # get the homeworld planet and the films
    $planet = Invoke-StarWarsApi -objectType Planets -id $person.homeworld
    $films = Invoke-StarWarsApi -objectType Films

    # build the result object as a mix of all the data returned
    $result = [PSCustomObject]@{
        Name = $person.Name
        BodyType = $person | Select-Object height, mass, gender, skin_color, eye_color
        HomeWorld = $planet | Select-Object name, population, gravity, terrain
        Films = $films | Where-Object url -in $person.films | Select-Object title, director, release_date
    }
    Write-Output $result
}



# other samples
# - www.swapi.tech
# - swapi.dev
