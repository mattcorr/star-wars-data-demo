BeforeAll {
    . $PSCommandPath.Replace('.Mocked.Tests.ps1','.ps1')

    Mock Invoke-StarWarsApi {  
        $output1 = [PSCustomObject]@{
            id     = 68
            name   = 'Bail Prestor Organa'
            gender = 'male'
            height = '191'
            weight = 'unknown'
        }
        $output2 = [PSCustomObject]@{
            id     = 2
            name   = 'Luke Skywalker'
            gender = 'male'
            height = '172'
            weight = '77'
        }
        $output3 = [PSCustomObject]@{
            id     = 2
            name   = 'Anakin Skywalker'
            gender = 'male'
            height = '188'
            weight = '84'
        }
        Write-Output @($output1, $output2, $output3)
    } -Verifiable -ParameterFilter { $objectType -eq 'People'} 

    Mock Invoke-StarWarsApi {  
        $output1 = [PSCustomObject]@{
            id         = 8
            name       = 'Naboo'
            population = 4500000000
            diameter   = 12120
            terrain    = @('grassy hills', 'swamps', 'forests', 'mountains')
        }
        $output2 = [PSCustomObject]@{
            id         = 1
            name       = 'Tatooine'
            population = 200000
            diameter   = 10465
            terrain    = @('desert')
        }
        $output3 = [PSCustomObject]@{
            id         = 25
            name       = 'Dantooine'
            population = 1000
            diameter   = 9830
            terrain    = @('oceans', 'savannas', 'mountains', 'grasslands')
        }
        Write-Output @($output1, $output2, $output3)
    } -Verifiable -ParameterFilter { $objectType -eq 'Planets'} 
}

Describe "Search-SWPerson" -Tag "Unit", "Mocked" {
    It "Returns a single match" {
        $testName = 'Bail'
        $result = Search-SWPerson -Name $testName

        $result.Count | Should -Be 1
        $result.name | Should -BeLike "*$testName*"
    }
    It "Returns no matches" {
        $testName = 'Invalid'
        $result = Search-SWPerson -Name $testName

        $result | Should -BeNullOrEmpty
    }
    It "Returns multiple matches" {
        $testName = 'walker'
        $result = Search-SWPerson -Name $testName

        $result.Count | Should -BeGreaterThan 1
    }
}

Describe "Search-SWPlanet" -Tag "Unit", "Mocked" {
    It "Returns a single match" {
        $testName = 'nabo'
        $result = Search-SWPlanet -Name $testName

        $result.Count | Should -Be 1
        $result.name | Should -BeLike "*$testName*"
    }
    It "Returns no matches" {
        $testName = 'Invalid'
        $result = Search-SWPlanet -Name $testName

        $result | Should -BeNullOrEmpty
    }
    It "Returns multiple matches" {
        $testName = 'too'
        $result = Search-SWPlanet -Name $testName

        $result.Count | Should -BeGreaterThan 1
    }
}