BeforeAll {
    . $PSCommandPath.Replace('.Simple.Tests.ps1','.ps1')
}

Describe "Search-SWPerson" {
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

Describe "Search-SWPlanet" {
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